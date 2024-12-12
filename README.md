# Terra Delicada

This repository contains the development of a **farming simulator** designed for **scalability**, **calming gameplay**, and **intuitive mechanics**. The game is focused on flower farming (roses, tulips, and marigolds) and integrates key gameplay mechanics such as point-and-click player movement, seed planting, growth cycles, and flower harvesting. 

As the lead for this project, Terra Delicada demonstrates my ability to architect a modular, scalable game design while balancing functionality and user experience. The long-term vision is to create a foundation that allows for expansions and eventual adaptation to mobile platforms with touch-and-move mechanics.

---

## Overview

**Terra Delicada**—from Spanish, "delicada" (“Delicate”) and Latin, "terra" ("Earth")—is a relaxing, top-down 2D game where players plant and harvest flowers in a seamless, minimalist environment. The gameplay is tied to a **day-night cycle** that influences seed growth, ensuring an immersive and paced experience. We are focusing on simple game mechanics, soothing music, and a clean UI, for ease of play, making it appropriate for all audiences.

Key features include:
- **Dynamic seed planting and harvesting mechanics**
- **Day-night cycle integrated into gameplay**
- **Minimalist UI** to reduce player distraction and overstimulation
- **Modular architecture** for future features like new crops and seasonal events
- **Mobile-ready systems** for easy adaptation to touch controls

This game is designed to be **easy and calming**, with minimal text and UI, relying on intuitive mechanics like point-and-click or touch movement.

---

## Core Elements

### **1. Player Interaction**
The player character moves with a **point-and-click system**, automatically planting seeds when standing on valid soil tiles. This ensures direct interaction between the player and the environment.

### **2. Soil Management**
Soil is represented as a **TileMapLayer**, where each tile tracks its state (empty, planted, or full) using metadata. This system allows:
- **Empty Checks**: Determines if a tile is available for planting.
- **Seed Planting**: Automatically updates the tile’s state upon planting.
- **Resetting Tiles**: Clears tiles for replanting or harvesting.

### **3. Seed Growth and Transformation**
Seeds grow in stages based on the **day-night cycle**, culminating in their transformation into flowers. Each seed type (roses, tulips, marigolds) can have unique growth rates and animations.

### **4. Flower Harvesting**
Flowers drop from seeds and are collected automatically when the player moves within range. A **global counter** tracks the total harvested flowers, which persist across sessions.

### **5. UI Integration**
The minimalist UI updates dynamically to display the flower count and progress. Future expansions could include achievements or more detailed statistics.

---

## Interaction Flow

1. **Player Movement**: The player clicks or taps to move to a target position.
2. **Seed Planting**: Seeds are planted automatically when the player walks over empty soil.
3. **Seed Growth**: Seeds progress through visual stages tied to the day-night cycle.
4. **Flower Harvesting**: Flowers are collected upon collision, updating the global counter.
5. **Progress Tracking**: The flower count is displayed dynamically in the UI.

---

## Meet the Team

### **Alyssa Pena– Head Developer and Project Architect**
- [Alyssa's Website](https://alyssavixp.github.io/avixp/)
Alyssa leads the development and overall architecture of the project, ensuring all systems are modular, scalable, and cohesive. She designed the core gameplay mechanics, structured the roadmap, and provided the vision for the game's technical and gameplay foundation. Her role also includes managing the team and ensuring smooth integration of all components.

### **Tianyi Fan– Creative Director and Systems Strategist**
- [Tianyi's Github](https://github.com/TianyiFan2003)
Tianyi conceptualized the original idea for the farming simulator and adapted it based on feedback to align with the project's goals. As the Creative Director and Systems Strategist, Tianyi did the initial research and developed the economic systems. He providing strategic direction for gameplay mechanics at the conception of the game. Tianyi is also responsible for final testing, balancing, and creating comprehensive documentation for the project.

---

## Roadmap and Schedule

The roadmap outlines the project’s milestones and individual responsibilities for each team member. You can access the detailed schedule and responsibilities [here](https://docs.google.com/spreadsheets/d/1AndOkuZt7aTz3yTIh8UfIwcude_4B6Dq68T3YKj7TmM/edit?usp=sharing).

---

## Design Philosophy

### **Systematic Design**
The game is built with modularity and scalability in mind, ensuring new features like crops, weather, and events can be easily added without altering core functionality.

### **Player-Centric Focus**
The gameplay is designed to feel intuitive and calming, with minimal UI and text. Mechanics rely on simple interactions, making the experience approachable for any player.

### **Future-Proofing**
The architecture allows seamless adaptation to mobile platforms, with planned touch-and-move mechanics for a broader audience.

---

## Future Improvements

### Planned Expansions:
- Seasonal cycles introducing unique crops and weather systems.
- Crafting mechanics or additional gameplay loops to increase depth.
- Enhanced UI for achievements, detailed stats, or meta-game elements.
- Multiplayer options to foster collaboration or competition.
- Mobile-friendly design for touch controls and compact UI.

---

## Contributions and Feedback

This project demonstrates my ability to build and manage the architecture of a game, from concept to functional prototype. Contributions and feedback are welcome to help refine and expand the project.

To learn more about our roadmap and team responsibilities, view the full [schedule here](https://docs.google.com/spreadsheets/d/1AndOkuZt7aTz3yTIh8UfIwcude_4B6Dq68T3YKj7TmM/edit?usp=sharing).

