
//
// Verific Verilog Description of module mAlu
//

module mAlu (PC, ReadData1, ReadData2, Instruction, ALUSelA, ALUSelB, 
            ALUOp, Zero, ALU_result);   // alu.v(28)
    input [7:0]PC;   // alu.v(43)
    input [7:0]ReadData1;   // alu.v(43)
    input [7:0]ReadData2;   // alu.v(45)
    input [15:0]Instruction;   // alu.v(46)
    input ALUSelA;   // alu.v(47)
    input [1:0]ALUSelB;   // alu.v(48)
    input [1:0]ALUOp;   // alu.v(49)
    output Zero;   // alu.v(51)
    output [7:0]ALU_result;   // alu.v(52)
    
    wire [7:0]MuxA;   // alu.v(54)
    wire [7:0]MuxB;   // alu.v(54)
    
    wire n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, 
        n31, n32, n33, n34, n35, n36, n38, n39, n40, n41, 
        n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, 
        n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, 
        n62, n63, n64, n65, n66, n67, n68, n69, n96, n97, 
        n98, n99, n100, n101, n102, n103, n107, n108, n112, 
        n115, n119, n122, n124;
    
    assign MuxA[7] = ALUSelA ? ReadData1[7] : PC[7];   // alu.v(71)
    assign MuxA[6] = ALUSelA ? ReadData1[6] : PC[6];   // alu.v(71)
    assign MuxA[5] = ALUSelA ? ReadData1[5] : PC[5];   // alu.v(71)
    assign MuxA[4] = ALUSelA ? ReadData1[4] : PC[4];   // alu.v(71)
    assign MuxA[3] = ALUSelA ? ReadData1[3] : PC[3];   // alu.v(71)
    assign MuxA[2] = ALUSelA ? ReadData1[2] : PC[2];   // alu.v(71)
    assign MuxA[1] = ALUSelA ? ReadData1[1] : PC[1];   // alu.v(71)
    assign MuxA[0] = ALUSelA ? ReadData1[0] : PC[0];   // alu.v(71)
    Mux_2u_4u Mux_11 (.sel({ALUSelB}), .data({Instruction[7], Instruction[7], 
            1'b0, ReadData2[7]}), .o(MuxB[7]));   // alu.v(88)
    Mux_2u_4u Mux_12 (.sel({ALUSelB}), .data({Instruction[6], Instruction[6], 
            1'b0, ReadData2[6]}), .o(MuxB[6]));   // alu.v(88)
    Mux_2u_4u Mux_13 (.sel({ALUSelB}), .data({Instruction[5], Instruction[5], 
            1'b0, ReadData2[5]}), .o(MuxB[5]));   // alu.v(88)
    Mux_2u_4u Mux_14 (.sel({ALUSelB}), .data({Instruction[4], Instruction[4], 
            1'b0, ReadData2[4]}), .o(MuxB[4]));   // alu.v(88)
    Mux_2u_4u Mux_15 (.sel({ALUSelB}), .data({Instruction[3], Instruction[3], 
            1'b0, ReadData2[3]}), .o(MuxB[3]));   // alu.v(88)
    Mux_2u_4u Mux_16 (.sel({ALUSelB}), .data({Instruction[2], Instruction[2], 
            1'b0, ReadData2[2]}), .o(MuxB[2]));   // alu.v(88)
    Mux_2u_4u Mux_17 (.sel({ALUSelB}), .data({Instruction[1], Instruction[1], 
            1'b0, ReadData2[1]}), .o(MuxB[1]));   // alu.v(88)
    Mux_2u_4u Mux_18 (.sel({ALUSelB}), .data({Instruction[0], Instruction[0], 
            1'b1, ReadData2[0]}), .o(MuxB[0]));   // alu.v(88)
    add_8u_8u add_19 (.cin(1'b0), .a({MuxA}), .b({MuxB}), .o({n21, n22, 
            n23, n24, n25, n26, n27, n28}));   // alu.v(97)
    not (n29, MuxB[7]) ;   // alu.v(98)
    not (n30, MuxB[6]) ;   // alu.v(98)
    not (n31, MuxB[5]) ;   // alu.v(98)
    not (n32, MuxB[4]) ;   // alu.v(98)
    not (n33, MuxB[3]) ;   // alu.v(98)
    not (n34, MuxB[2]) ;   // alu.v(98)
    not (n35, MuxB[1]) ;   // alu.v(98)
    not (n36, MuxB[0]) ;   // alu.v(98)
    add_8u_8u add_28 (.cin(1'b1), .a({MuxA}), .b({n29, n30, n31, n32, 
            n33, n34, n35, n36}), .o({n38, n39, n40, n41, n42, 
            n43, n44, n45}));   // alu.v(98)
    and (n46, MuxA[0], MuxB[0]) ;   // alu.v(100)
    and (n47, MuxA[1], MuxB[1]) ;   // alu.v(100)
    and (n48, MuxA[2], MuxB[2]) ;   // alu.v(100)
    and (n49, MuxA[3], MuxB[3]) ;   // alu.v(100)
    and (n50, MuxA[4], MuxB[4]) ;   // alu.v(100)
    and (n51, MuxA[5], MuxB[5]) ;   // alu.v(100)
    and (n52, MuxA[6], MuxB[6]) ;   // alu.v(100)
    and (n53, MuxA[7], MuxB[7]) ;   // alu.v(100)
    or (n54, MuxA[0], MuxB[0]) ;   // alu.v(101)
    or (n55, MuxA[1], MuxB[1]) ;   // alu.v(101)
    or (n56, MuxA[2], MuxB[2]) ;   // alu.v(101)
    or (n57, MuxA[3], MuxB[3]) ;   // alu.v(101)
    or (n58, MuxA[4], MuxB[4]) ;   // alu.v(101)
    or (n59, MuxA[5], MuxB[5]) ;   // alu.v(101)
    or (n60, MuxA[6], MuxB[6]) ;   // alu.v(101)
    or (n61, MuxA[7], MuxB[7]) ;   // alu.v(101)
    xor (n62, MuxA[0], MuxB[0]) ;   // alu.v(102)
    xor (n63, MuxA[1], MuxB[1]) ;   // alu.v(102)
    xor (n64, MuxA[2], MuxB[2]) ;   // alu.v(102)
    xor (n65, MuxA[3], MuxB[3]) ;   // alu.v(102)
    xor (n66, MuxA[4], MuxB[4]) ;   // alu.v(102)
    xor (n67, MuxA[5], MuxB[5]) ;   // alu.v(102)
    xor (n68, MuxA[6], MuxB[6]) ;   // alu.v(102)
    xor (n69, MuxA[7], MuxB[7]) ;   // alu.v(102)
    nor (n96, ALUOp[1], ALUOp[0]) ;   // alu.v(97)
    not (n97, ALUOp[0]) ;   // alu.v(98)
    nor (n98, ALUOp[1], n97) ;   // alu.v(98)
    not (n99, Instruction[2]) ;   // alu.v(100)
    not (n100, Instruction[5]) ;   // alu.v(100)
    not (n101, ALUOp[1]) ;   // alu.v(100)
    nor (n102, n101, ALUOp[0], n100, Instruction[4], Instruction[3], 
        n99, Instruction[1], Instruction[0]) ;   // alu.v(100)
    not (n103, Instruction[0]) ;   // alu.v(101)
    nor (n107, n101, ALUOp[0], n100, Instruction[4], Instruction[3], 
        n99, Instruction[1], n103) ;   // alu.v(101)
    not (n108, Instruction[1]) ;   // alu.v(102)
    nor (n112, n101, ALUOp[0], n100, Instruction[4], Instruction[3], 
        n99, n108, Instruction[0]) ;   // alu.v(102)
    nor (n115, n101, ALUOp[0], n100, Instruction[4], Instruction[3], 
        Instruction[2], Instruction[1], Instruction[0]) ;   // alu.v(103)
    nor (n119, n101, ALUOp[0], n100, Instruction[4], Instruction[3], 
        Instruction[2], n108, Instruction[0]) ;   // alu.v(104)
    nor (n122, n101, ALUOp[0], Instruction[5], Instruction[4], Instruction[3], 
        Instruction[2], n108, Instruction[0]) ;   // alu.v(105)
    nor (n124, n101, ALUOp[0], Instruction[5], Instruction[4], Instruction[3], 
        Instruction[2], Instruction[1], Instruction[0]) ;   // alu.v(106)
    Select_9 Select_93 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n21, n38, n53, n61, n69, 
            n21, n38, 1'b0, MuxB[6]}), .o(ALU_result[7]));   // alu.v(109)
    Select_9 Select_94 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n22, n39, n52, n60, n68, 
            n22, n39, MuxB[7], MuxB[5]}), .o(ALU_result[6]));   // alu.v(109)
    Select_9 Select_95 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n23, n40, n51, n59, n67, 
            n23, n40, MuxB[6], MuxB[4]}), .o(ALU_result[5]));   // alu.v(109)
    Select_9 Select_96 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n24, n41, n50, n58, n66, 
            n24, n41, MuxB[5], MuxB[3]}), .o(ALU_result[4]));   // alu.v(109)
    Select_9 Select_97 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n25, n42, n49, n57, n65, 
            n25, n42, MuxB[4], MuxB[2]}), .o(ALU_result[3]));   // alu.v(109)
    Select_9 Select_98 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n26, n43, n48, n56, n64, 
            n26, n43, MuxB[3], MuxB[1]}), .o(ALU_result[2]));   // alu.v(109)
    Select_9 Select_99 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n27, n44, n47, n55, n63, 
            n27, n44, MuxB[2], MuxB[0]}), .o(ALU_result[1]));   // alu.v(109)
    Select_9 Select_100 (.sel({n96, n98, n102, n107, n112, n115, 
            n119, n122, n124}), .data({n28, n45, n46, n54, n62, 
            n28, n45, MuxB[1], 1'b0}), .o(ALU_result[0]));   // alu.v(109)
    nor (Zero, ALU_result[7], ALU_result[6], ALU_result[5], ALU_result[4], 
            ALU_result[3], ALU_result[2], ALU_result[1], ALU_result[0]) ;   // alu.v(111)
    
endmodule

//
// Verific Verilog Description of OPERATOR Mux_2u_4u
//

module Mux_2u_4u (sel, data, o);
    input [1:0]sel;
    input [3:0]data;
    output o;
    
    
    wire n1, n2;
    
    assign n1 = sel[0] ? data[1] : data[0];
    assign n2 = sel[0] ? data[3] : data[2];
    assign o = sel[1] ? n2 : n1;
    
endmodule

//
// Verific Verilog Description of OPERATOR add_8u_8u
//

module add_8u_8u (cin, a, b, o, cout);
    input cin;
    input [7:0]a;
    input [7:0]b;
    output [7:0]o;
    output cout;
    
    
    wire n2, n4, n6, n8, n10, n12, n14;
    
    VERIFIC_FADD i1 (.cin(cin), .a(a[0]), .b(b[0]), .o(o[0]), .cout(n2));
    VERIFIC_FADD i2 (.cin(n2), .a(a[1]), .b(b[1]), .o(o[1]), .cout(n4));
    VERIFIC_FADD i3 (.cin(n4), .a(a[2]), .b(b[2]), .o(o[2]), .cout(n6));
    VERIFIC_FADD i4 (.cin(n6), .a(a[3]), .b(b[3]), .o(o[3]), .cout(n8));
    VERIFIC_FADD i5 (.cin(n8), .a(a[4]), .b(b[4]), .o(o[4]), .cout(n10));
    VERIFIC_FADD i6 (.cin(n10), .a(a[5]), .b(b[5]), .o(o[5]), .cout(n12));
    VERIFIC_FADD i7 (.cin(n12), .a(a[6]), .b(b[6]), .o(o[6]), .cout(n14));
    VERIFIC_FADD i8 (.cin(n14), .a(a[7]), .b(b[7]), .o(o[7]), .cout(cout));
    
endmodule

//
// Verific Verilog Description of OPERATOR Select_9
//

module Select_9 (sel, data, o);
    input [8:0]sel;
    input [8:0]data;
    output o;
    
    
    wire n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, 
        n12, n13, n14, n15, n16;
    
    and (n1, data[0], sel[0]) ;
    and (n2, data[1], sel[1]) ;
    and (n3, data[2], sel[2]) ;
    and (n4, data[3], sel[3]) ;
    and (n5, data[4], sel[4]) ;
    and (n6, data[5], sel[5]) ;
    and (n7, data[6], sel[6]) ;
    and (n8, data[7], sel[7]) ;
    and (n9, data[8], sel[8]) ;
    or (n10, n1, n2) ;
    or (n11, n3, n4) ;
    or (n12, n10, n11) ;
    or (n13, n5, n6) ;
    or (n14, n8, n9) ;
    or (n15, n7, n14) ;
    or (n16, n13, n15) ;
    or (o, n12, n16) ;
    
endmodule
