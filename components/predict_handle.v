module predict_handler (
    input Predicted,
    input Actual,
    input branch,
    input jump,
    output Eval_branch,
    output Target_sel
);

assign Eval_branch = ((Predicted == Actual) && (jump | branch) ) ? 1'b1 : 1'b0;
assign Target_sel = (~Predicted & Actual) ? 0 : 1;
endmodule