module predict_handler (
    input Predicted,
    input Actual,
    input branch,
    input jump,
    output Eval_branch,
    output Target_sel,
    output Prediction_Correct
);

assign Eval_branch = ((Predicted != Actual) && (jump | branch) ) ? 1'b1: 1'b10;
assign Target_sel = (~Predicted & Actual) ? 0 : 1;
assign Prediction_Correct = ((Predicted == Actual) && (jump | branch)  ) ? 1'b1 : 1'b0;
endmodule