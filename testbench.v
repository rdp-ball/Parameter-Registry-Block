module prb_tb;

    reg clk, reset, param_id;
    reg [7:0] data;
    wire [10:0] mask_param, code_param;
    wire [1:0] sjw;
    
    // Instantiate the PARAM_BLOCK module
    prb dut (
        .param_id(param_id),
        .clk(clk),
        .reset (reset),
        .data(data),
        .mask_param(mask_param),
        .code_param(code_param),
        .sjw(sjw)
    );
    
    always #5 c1k=~clk;
    initial begin
        $monitor("Data = %8b, Data_Reg = %8b, param_id = %1b\nState_Reg = %3b\nmask_param = %11b, code_param = %11b, sjw = %2b",
        dut. data, dut.data_reg, dut.param_id, dut.state_reg, dut.mask_param, dut.code_param, dut.sjw); 
        clk=0;
        reset=1;
        param_id=0;
        data=8'b11110000;
        #20 reset=0;
        #60 param_id=1;
        data=8'b10101010;
        #10 param_id=0;
        #60 param_id=1;
        data=8' b00001111;
        #10 param_id=0;
        #60 param_id=1;
        data=8'b00110011;
        #10 reset=1;
        #60 reset=0;
        data=8'b01010101 ;
        #10 param_id=0;
        #60 param_id=1;
        data=~data;
        #10 param_id=0;
        #60 param_id=1;
        $finish;
    end
endmodule
