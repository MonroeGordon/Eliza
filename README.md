# Eliza Chatbot in Assembly

I rewrote the eliza.bas QuickBasic64 source code into MASM Assembly. The project contains the following modules:

eliza.asm - The main source file that runs the program loop. This is still in development.
console.asm - Processes input/output to the console.
keyword.asm - Stores and retrieves keywords that Eliza responds to in the user's input.
reply.asm - Stores and retrieves the replies Eliza uses to respond back to the user. This is still in development. This is still in development.
conjugate.asm - Stores and processes string conjugations needed to help Eliza have more natural speech in her responses. This is still in development.
string.asm - A library of string manipulation functions used by other modules to process the user's input and form Eliza's response. This is still in development.

You can also view the original eliza.bas QuickBasic64 source code in the Eliza directory.
