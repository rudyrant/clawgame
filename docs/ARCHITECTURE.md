# Technical Stack: Godot 4.x (Mobile/Forward+)

## Architecture
- **WorldManager**: Handles OpenSimplexNoise generation and tile/object placement.
- **Player**: CharacterBody2D with state machine (Idle, Moving, Hitting).
- **InventoryManager**: Resource-based system for the 5-slot hotbar + crafting.
- **InteractionSystem**: RayCast2D or Area2D to detect "in front" objects.

## Data Structures
- **ItemResource**: Base class for items (tools, materials).
- **Interactable**: Base class for Trees and Bushes.

## Sprint 1: Prototype
1. Setup base project config (Android export presets).
2. Implement 2D movement.
3. Generate noise-based map with boundaries.
4. Spawn breakable Trees (Wood) and decorative Bushes.
