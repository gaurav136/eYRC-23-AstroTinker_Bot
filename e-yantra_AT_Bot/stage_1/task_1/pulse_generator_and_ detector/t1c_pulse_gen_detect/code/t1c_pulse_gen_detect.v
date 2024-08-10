// module t1c_pulse_gen_detect (
//     input clk_50M,
//     reset,
//     echo_rx,
//     output reg trigger,
//     out,
//     output reg [21:0] pulses,
//     output reg [1:0] state
// );

//   reg [21:0] pulses_counter;

//   initial begin
//     trigger = 0;
//     out = 0;
//     pulses = 0;
//     state = 0;
//   end

//   //////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

//   localparam warm_up = 2'b00;
//   localparam trigger_pulse = 2'b01;
//   localparam read_pulse = 2'b10;
//   localparam creat_output = 2'b11;

//   integer counter = 0;

//   always @(posedge clk_50M) begin
//     if (reset) begin
//       pulses <= 0;
//       state <= warm_up;
//       counter <= 0;
//       pulses_counter <= 0;
//       trigger <= 0;
//       out = 0;
//     end else begin
//       case (state)
//         warm_up: begin
//           if (counter < 49) begin
//             state   <= warm_up;
//             counter <= counter + 1;
//           end else begin
//             counter <= 0;
//             state   <= trigger_pulse;
//           end
//         end

//         trigger_pulse: begin
//           if (counter < 500) begin
//             trigger <= 1;  // Generate a 500-clock pulse at the start
//           end else begin
//             trigger <= 0;  // End the pulse after 500 cycles
//           end

//           if (counter < 49999) begin
//             if (echo_rx) begin
//               pulses_counter <= pulses_counter + 1;
//             end
//             counter <= counter + 1;
//           end else begin
//             counter <= 0;
//             state <= read_pulse;
//           end
//         end

//         read_pulse: begin
//           pulses <= pulses_counter;
//           if (pulses >= 29410) begin
//             state <= creat_output;
//           end
//         end

//         creat_output: begin
//           out <= 1;
//           state <= warm_up;
//         end

//         default: state <= warm_up;
//       endcase
//     end
//   end

//   //////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

// endmodule

module t1c_pulse_gen_detect (
    input clk_50M,
    reset,
    echo_rx,
    output reg trigger,
    out,
    output reg [21:0] pulses,
    output reg [1:0] state
);


  initial begin
    trigger = 0;
    out = 0;
    pulses = 0;
    state = 0;
  end

  //////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

  localparam warm_up = 2'b00;
  localparam trigger_pulse = 2'b01;
  localparam read_pulse = 2'b10;
  localparam creat_output = 2'b11;

  integer counter = 0;

  always @(posedge clk_50M) begin
    if (reset) begin
      pulses <= 0;
      state <= warm_up;
      counter <= 0;
      trigger <= 0;
      out = 0;
    end else begin
      case (state)
        warm_up: begin
          if (counter < 49) begin
            state   <= warm_up;
            counter <= counter + 1;
          end else begin
            counter <= 0;
            state   <= trigger_pulse;
          end
        end

        trigger_pulse: begin
          if (counter < 500) begin
            trigger <= 1;  // Generate a 500-clock pulse at the start
            state   <= trigger_pulse;
            counter <= counter + 1;
          end else begin
            if (echo_rx) begin   // 1 milli second starting for here
              pulses <= pulses + 1;
            end
            trigger <= 0;  // End the pulse after 500 cycles
            state   <= read_pulse;
            counter <= 0;
          end
        end

        read_pulse: begin
          if (counter < 49998) begin
            if (echo_rx) begin
              pulses <= pulses + 1;
            end
            counter <= counter + 1;
            state   <= read_pulse;
          end else begin
            counter <= 0;
            state   <= creat_output;
          end

        end

        creat_output: begin
          if (pulses >= 29410) begin
            out   <= 1;
            state <= warm_up;
          end
          state   <= warm_up;
        end

        default: state <= warm_up;
      endcase
    end
  end

  //////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule

