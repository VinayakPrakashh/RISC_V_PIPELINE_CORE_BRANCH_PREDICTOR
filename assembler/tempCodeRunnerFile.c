#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
// Function to encode "add rd, rs1, rs2"
uint32_t encode_add(int rd, int rs1, int rs2) {
    uint32_t funct7 = 0x00;
    uint32_t funct3 = 0x00;
    uint32_t opcode = 0x33;  // 0110011 in binary

    uint32_t instr = 0;
    instr |= (funct7 << 25);
    instr |= (rs2    << 20);
    instr |= (rs1    << 15);
    instr |= (funct3 << 12);
    instr |= (rd     << 7);
    instr |= opcode;

    return instr;
}

// Function to parse a line and call correct encoder
void process_line(char *line) {
    char instr[10];
    int rd, rs1, rs2;

    // Try to match: add x1, x2, x3
    if (sscanf(line, "%s x%d, x%d, x%d", instr, &rd, &rs1, &rs2) == 4) {
        if (strcmp(instr, "add") == 0) {
            uint32_t machine = encode_add(rd, rs1, rs2);
            printf("%s -> 0x%08X\n", line, machine);
        } else {
            printf("Unknown instruction: %s\n", instr);
        }
    }
}


int main() {
    FILE *fp;
    char line[256];   // buffer for each line

    // open the assembly file
    fp = fopen("program.asm", "r");
    if (fp == NULL) {
        printf("Error: cannot open file\n");
        return 1;
    }
    else{
        printf("File found\n");
    }
    printf("Processing file line by line...");
    while (fgets(line, sizeof(line), fp)) {
        process_line(line);
    }

}
