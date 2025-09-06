#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

// General R-type instruction encoder
uint32_t encode_rtype(int funct7, int rs2, int rs1, int funct3, int rd, int opcode) {
    uint32_t instr = 0;

    instr |= ((funct7 & 0x7F) << 25); // bits 31–25
    instr |= ((rs2   & 0x1F) << 20);  // bits 24–20
    instr |= ((rs1   & 0x1F) << 15);  // bits 19–15
    instr |= ((funct3& 0x07) << 12);  // bits 14–12
    instr |= ((rd    & 0x1F) << 7);   // bits 11–7
    instr |=  (opcode & 0x7F);        // bits 6–0

    return instr;
}

// Structure to hold instruction info
typedef struct {
    char name[10];
    int funct7;
    int funct3;
    int opcode;
} InstrInfo;

// Instruction table (can extend)
InstrInfo rtype_table[] = {
    {"add", 0x00, 0x0, 0x33},
    {"sub", 0x20, 0x0, 0x33},
    {"and", 0x00, 0x7, 0x33},
    {"or",  0x00, 0x6, 0x33},
    {"xor", 0x00, 0x4, 0x33},
};

int table_size = sizeof(rtype_table) / sizeof(rtype_table[0]);

// Function to parse a line and call correct encoder
void process_line(char *line) {
    char instr[10];
    int rd, rs1, rs2;

    // Remove newline if present
    line[strcspn(line, "\n")] = 0;

    // Match pattern: add x1, x2, x3
    if (sscanf(line, "%s x%d, x%d, x%d", instr, &rd, &rs1, &rs2) == 4) {
        for (int i = 0; i < table_size; i++) {
            if (strcmp(instr, rtype_table[i].name) == 0) {
                uint32_t machine = encode_rtype(
                    rtype_table[i].funct7,
                    rs2, rs1,
                    rtype_table[i].funct3,
                    rd,
                    rtype_table[i].opcode
                );
                printf("%08X\n", machine); // only print machine code
                return;
            }
        }
        printf("// Unknown instruction: %s\n", instr);
    }
}

int main() {
    FILE *fp;
    char line[256];

    // Open the assembly file
    fp = fopen("program.asm", "r");
    if (fp == NULL) {
        printf("Error: cannot open file\n");
        return 1;
    }

    // Process each line
    while (fgets(line, sizeof(line), fp)) {
        process_line(line);
    }

    fclose(fp);
    return 0;
}
