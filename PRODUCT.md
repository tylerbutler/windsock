# Product

## Register

product

## Users

Gleam developers building Socket.IO or Engine.IO integrations. They are likely working close to transport or protocol boundaries and need small, predictable primitives they can compose into their own clients, servers, or higher-level protocol layers.

## Product Purpose

windsock provides intentionally narrow Socket.IO / Engine.IO text-frame primitives for Gleam: encoding and decoding Socket.IO event packets, plus heartbeat constants. It exists to keep frame handling explicit, dependable, and dependency-light without pretending to be a full Socket.IO client or server. Success means developers can understand the supported frame shapes immediately, trust error behavior, and layer their own protocol vocabulary on top.

## Brand Personality

Minimal, technical, exacting. The product should feel like a precise protocol tool: quiet, readable, and serious about boundaries.

## Anti-references

Avoid SaaS-template marketing, oversized hero metrics, decorative protocol diagrams, gradient text, glassy cards, and anything that makes a narrow library feel like a platform pitch. Do not lean on literal wind/sock imagery unless it becomes a deliberate brand system later.

## Design Principles

- Keep the boundary visible: show exactly what windsock owns and what callers own.
- Prefer inspectable examples over persuasion: concrete frames, concrete errors, concrete outputs.
- Make narrowness feel intentional, not incomplete.
- Optimize for trust at protocol edges: stable terminology, restrained hierarchy, and no decorative ambiguity.
- Preserve Gleam-native clarity: concise copy, obvious module boundaries, and examples that look like real code.

## Accessibility & Inclusion

Use WCAG 2.2 AA as the baseline for any future UI or documentation surface. Support reduced motion, do not rely on color alone for meaning, and keep examples and reference content readable with strong contrast and predictable structure.
