module bfloat_add_sub(a,b,c,cntl,clk);
input logic [15:0]a,b;
output logic [15:0]c;
input logic cntl,clk;

bit [15:0]a1,b1,b2,temp;
logic cntl1;
logic [7:0]ea,eb,e,bias; //bias dimension
logic [6:0]ma,mb,m_f;
logic [11:0] ma_temp,mb_temp,m_add,m_temp,msub;
logic [8:0]m1;
logic g,r,s0,s1,s,p,s3;
int l;
bit x;

always@(posedge clk)
  begin
//NaN
if(((a[15:7]==9'b111111111 && b[15:7]==9'b011111111 && cntl==0)||(a1[15:7]==9'b011111111 && b[15:7]==9'b111111111 && cntl==0)) )
c<=16'b1111111111111111;
else if((a[15:7]==9'b011111111 && b[15:7]==9'b011111111 && cntl==1))
c<=16'b1111111111111111;
else if((a[15:7]==9'b111111111 && b[15:7]==9'b111111111 && cntl==1))
c<=16'b1111111111111111;
//Inf
else if((((a[15:7]==9'b011111111 && b[15:7]==9'b011111111)&&cntl==0)||((a[15:7]==9'b011111111 && b[15:7]==9'b111111111)) && cntl==1))
begin
c[15]<=1'b0;
c[14:7]<=8'b11111111;
c[6:0]<=7'b0;
end
else if((((a[14:7]!=8'b11111111 && b[15:7]==9'b011111111)&& cntl==0)||(a1[15:7]==9'b011111111 && b[14:7]!=8'b11111111)||(a[14:7]!=8'b11111111 && b[15:7]==9'b111111111)&& cntl==1))
begin
c[15]<=1'b0;
c[14:7]<=8'b11111111;
c[6:0]<=7'b0;
end
//-Inf
else if((((a[15:7]==9'b111111111 && b[15:7]==9'b111111111)&&cntl==0)||(a1[15:7]==9'b111111111 && b[15:7]==9'b011111111 && cntl==1)))
begin
c[15]<=1'b1;
c[14:7]<=8'b11111111;
c[6:0]<=7'b0;
end
else if((((a[14:7]!=8'b11111111 && b[15:7]==9'b111111111)&&cntl==0)||((a[15:7]==9'b111111111 && b[14:7]!=8'b11111111))))
begin
c[15]<=1'b1;
c[14:7]<=8'b11111111;
c[6:0]<=7'b0;
end
//checking for subnormal/zero before add/sub operation
 //if both a and b are subnormal/zer0
if ((a[14:7] == 8'b00000000 && b[14:7] == 8'b00000000) && (cntl == 0 || cntl == 1))
   begin
     if((a[15]!=b[15])&& cntl==0)
       c<=16'b0;
     else
       begin
       c[15]<=a[15];
       c[14:0]<=15'b0;
       end
   end
//if a or b are subnormal/zero
if ((a[14:7] == 8'b00000000 || b[14:7] == 8'b00000000) && (cntl == 0 || cntl == 1)) begin
    if (a[14:7] == 8'b00000000)
      begin
        if (cntl == 1) begin
            c[15] = ~b[15]; // c = 0 - b = -b
            c[14:0] = b[14:0];
        end
        else
            c = b; // c = 0 + b = b
    end
    else
        c = a; // c = a + 0 = a or c = a - 0 = a
end
          
else
begin
  if( e==8'b0)//checking for subnormal after add/sub operation
    begin
      c[15]<=s3; //keeping the sign as obtained in the result
      c[6:0]<=7'b0;//pushing mantissa to zero
      c[14:7]<=e;
    end
  else 
    begin
      c[15]<=s3; 
      c[6:0]<=m_f;//keeping the mantissa obtained in result when it is not subnormal or zero 
      c[14:7]<=e;
    end
end
  end

always_comb
begin
   a1=a;
   b1=b;
   cntl1=cntl;
   
   
 if(cntl1==1) //if cntl is 1 then subtraction
 begin
    b1[15]=~b1[15];
end
   

   
    if(a1[14:7]<b1[14:7]) //making the larger number a
      begin
        temp=a1;
        a1=b1;
        b1=temp;
      end
  else if(a1[14:7]==b1[14:7])
  begin
    if(a1[6:0]<b1[6:0])
        begin
        temp=a1;
        a1=b1;
        b1=temp;
        end
  end
  else
    begin
    a1=a1;
    b1=b1;
    end
      
ea=a1[14:7];
eb=b1[14:7];

ma=a1[6:0];
mb=b1[6:0];
    
bias=ea-eb;
s3=a1[15];

ma_temp[11]=0;
mb_temp[11]=0;
ma_temp[10]=1;
mb_temp[10]=1;
ma_temp[9:3]=ma;
mb_temp[9:3]=mb;
ma_temp[2:0]=0;
mb_temp[2:0]=0;

mb_temp=mb_temp>>bias;

if(a1[15]==b1[15])
begin

m_add=ma_temp+mb_temp;

e=m_add[11]?(ea+1):ea;
m_temp[9:0]=m_add[11]?m_add[10:1]:m_add[9:0];
m_temp[10]=1;
m_temp[11]=0;

//rounding off
g=m_temp[3];
r=m_temp[2];
s0=m_temp[0];
s1=m_temp[1];
s=s0|s1;
    
p=r&(((~g)&s)|g);

if(p)
    m1=m_temp[11:3]+1;
else
    m1=m_temp[11:3];



m_f=m1[8]?(m1[7:1]):m1[6:0];
e=m1[8]?(e+1):e;
end
else if(a1[15]!=b1[15])
begin
e=ea;
 if(bias==2'b00)
      mb_temp[11:3]=(~mb_temp[11:3])+1;
    else if(bias==2'b01)
      mb_temp[11:2]=(~mb_temp[11:2])+1;
    else if(bias==2'b10)
      mb_temp[11:1]=(~mb_temp[11:1])+1;
    else if(bias==2'b11)
      mb_temp[11:0]=(~mb_temp[11:0])+1;
    else
      mb_temp=(~mb_temp);
    
    msub=ma_temp+mb_temp;
    
    
    g=msub[3];
    r=msub[2];
    s0=msub[0];
    s1=msub[1];
    s=s0|s1;
    
   
    p=r&(((~g)&s)|g);
    if(p)
      m1=msub[10:3]+1;
    else
      m1=msub[10:3];
    
    for(l=0;l<9;l=l+1)
    begin
    if(~m1[7])
        begin
        if(m1!=0)
        begin
          m1=m1<<1;
          e=e-1;
          if(m1[7])
          begin
          break;
          end
        end
      else
        m1=m1;
        end
        end
   
    m_f=m1[6:0];
    

end


end


    
endmodule
