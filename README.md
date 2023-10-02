# ARMCortexM4_SVC_Handler
An assembly level code targeted at ARM Cortex M4 architecture where for a particular SVC call made, the SVC handler checks the embedded SVC number and performs the required task

The SVC number is embedded into the SVC instruction. The ASM code snippet of the SVC handler extracts this number from the stack frame using the following steps:
* MRS is a special instruction used to read system registers, it copies the stack frame into one of the GPR
* While vectoring to execute SVC handler, the processor has stacked registers R0 to R3, R12 and LR each of which are 4 bytes wide (& there are six registers in total)
* Using the PC value, traversing back 2 bytes will provide the SVC number (stored in the lower byte of the instruction)
* The SVC number can be compared to the desired value and a required operation can be performed if there is a match
