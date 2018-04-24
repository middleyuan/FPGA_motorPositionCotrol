
module motor_click
(
input  clk_48    , 
input  reset_n   ,
input  EN_180_90 ,        //  1 for 90 , 0 for 180
input  command   ,
input   [11:0] pos ,

output reg [11:0] errorabs,
output reg signed [11:0] error,
output reg errorsign 


);
reg   [11:0] next_errorabs ;
reg signed  [11:0] next_error ;
reg   [11:0] pos_reg ; 
reg next_errorsign;

always @(posedge clk_48 or negedge reset_n)

begin
 
    if (reset_n == 0) 
	 begin
	 errorabs <= 0 ;
	 error <=  0 ;
	 pos_reg <= 0 ;
	 errorsign <= 0;
	 end
	 
    else
	 
	 begin
	    pos_reg  <= pos ;
       error  <= next_error ;  
		 errorabs  <= next_errorabs ;
		 errorsign <= next_errorsign ;
	 end		
     

end



always @(*)
begin 

   next_error  = error ;
   next_errorabs = errorabs ;
	next_errorsign = errorsign ;

	
	if (EN_180_90 ==  0 )//&& command  == 1  )  // 0 for 180  
	begin
	   next_error = 174 - pos_reg ;
	
	   if(next_error < 0)	begin
		next_errorabs =  -next_error ;
		next_errorsign = 1;
		end
	   else begin
		next_errorabs = next_error ;
		next_errorsign = 0;
		end
	end
	
	
	if (EN_180_90 ==  1 )// && command  == 1 )  // 1 for 90  
	
	begin
	next_error = 87 - pos_reg ;

	
	
      if(next_error < 0 )	begin	
		next_errorabs =  -next_error ;
		next_errorsign = 1;
		end
	   else begin
		next_errorabs = next_error ;
	   next_errorsign = 0;
		end
	

	
   end


end 


endmodule 