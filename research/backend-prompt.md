# Backend approach

I wish to build an AI-native application (SSD) where Claude writes the code. However I'd like the generated backend code to be migrate-able between NextJS (easy deployment) and NestJS (enterprise quality). What is the best approach?

1. Re-generate the two environments with AI, directly from the spec.
2. Build and test on NextJS first, then migrate the backend to NestJS if required.
3. Build and test with a NextJS front end and NestJS backend first, then migrate the backend to NestJS if required.

Write your recommendation to research/backend.md