# Backend Architecture Recommendation

> Research question from: `research/backend-prompt.md`

## Recommendation: Option 2 — NextJS first, with enforced service-layer discipline

Start with NextJS API routes. If enterprise deployment requirements emerge, migrate the backend to NestJS. The migration is tractable — but only if the code is written the right way from day one.

---

## Reasoning

### Why not Option 1 (re-generate both from spec)?

Maintaining two codebases from the same spec sounds clean in theory. In practice it creates divergence immediately: bugs fixed in one must be fixed in both, features added to one lag in the other, and the spec must be precise enough to drive identical AI-generated behaviour in two structurally different frameworks. For a project where Claude writes the code, this doubles review burden and doubles test surface for no early-stage benefit. Discard this unless you have a specific requirement to ship both simultaneously.

### Why not Option 3 (NextJS frontend + NestJS backend from day one)?

NestJS from day one is the right *eventual* architecture, but it adds real friction early:
- Two servers to run locally, coordinate, and deploy
- CORS, auth, and session handling must be configured explicitly across the boundary
- Vercel's first-class NextJS deployment story disappears; you now need a second hosting target (Railway, Fly.io, Render) for the NestJS process from day one
- AI-generated NestJS code is reliable, but the bootstrapping overhead (modules, DI configuration, guards, interceptors) slows the first week of development compared to NextJS API routes

The complexity is justified at scale. It is premature before the first user.

### Why Option 2 works — with one condition

NextJS API routes and NestJS controllers are structurally different. A naïve "just rewrite the routes as NestJS controllers" migration is painful. But the migration becomes mechanical if the code follows a strict pattern from day one:

**Thin handlers + isolated service classes**

Every API route handler must:
1. Parse the incoming request (extract params, body, auth context)
2. Call a service class method
3. Return the response

All business logic must live in `src/services/*.ts` — plain TypeScript classes with no dependency on Next.js types (`NextRequest`, `NextResponse`) or the Next.js runtime.

```
app/api/projects/route.ts        ← thin: parse → call service → return
src/services/ProjectService.ts   ← fat: all logic here, no Next.js imports
src/repositories/ProjectRepo.ts  ← data access, also framework-agnostic
```

When migrating to NestJS, the service files move unchanged. The migration task becomes: write NestJS controllers that call the existing services, configure the DI container, and add decorators. Claude can do this migration reliably given the existing service code as context.

---

## How to instruct Claude to enforce this pattern

Include the following rule in your CLAUDE.md or in every code generation prompt:

> **Backend pattern (mandatory):** Every NextJS API route handler must be a thin adapter. Parse the request, call a method on the corresponding service class in `src/services/`, and return the response. No business logic in route files. Service classes must import only from Node.js standard library, your database client, and other services — never from `next` or `next/server`.

This is Claude-friendly: it is a clear, checkable constraint that AI code generation handles reliably.

---

## Migration trigger criteria

Migrate from NextJS API routes to NestJS backend when **any two** of the following are true:

- A customer requires on-premises or private cloud deployment (Vercel is not an option)
- You need background jobs, queues, or WebSocket connections that don't fit Vercel's serverless model
- The team exceeds ~5 backend engineers and needs formal module boundaries enforced by the framework
- Enterprise sales require SLA-backed infrastructure separate from the frontend deployment

Until then, NextJS is sufficient and cheaper to operate.

---

## Summary

| | Option 1 (dual-gen) | Option 2 (Next first) | Option 3 (Next+Nest) |
|---|---|---|---|
| Time to first deployment | Slow | **Fast** | Medium |
| Codebase complexity | High | **Low** | Medium |
| Migration cost (later) | None needed | Low (with discipline) | None needed |
| AI generation reliability | Medium | **High** | High |
| Recommended for | Never | **Now** | Post-product-market fit |

**Choose Option 2. Enforce thin handlers + service layer from commit 1. Revisit when migration triggers appear.**
