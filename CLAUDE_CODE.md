# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 🎮 8-Bit Adventure Hub - YouTube Content Creation Codebase

This repository contains a comprehensive YouTube channel management system for "8-Bit Adventure Hub" - a music production and content creation project specializing in 8-bit chiptune RPG music collections.

## 🏗️ Architecture Overview

### Project Structure
```
XXX-[collection-name]/          # Music collection directories (001-adventure, 002-battle, etc.)
├── 01-master/                  # Master audio/video files and thumbnails
├── 02-Individual-music/        # Individual WAV files for each track
├── 03-Individual-movie/        # Individual MP4 files for each track
└── 10-thumbnail/              # Thumbnail assets

200-docs/                      # Knowledge management system
├── knowledges/                # Core project documentation (8 files)
├── awareness/                 # Project insights and learnings
└── tweets/                    # Daily work logs

working/                       # Temporary work files for current tasks
100-image/                     # Image assets
```

### Core Systems

1. **Collection Management System**: Each music collection follows a standardized 3-tier structure (master → individual music → individual video → thumbnails)

2. **Knowledge Management**: Comprehensive documentation system with master knowledge base, specialized guides, and continuous learning capture

3. **Content Production Pipeline**: Automated workflow from AI music generation → video creation → YouTube optimization

## 🛠️ Common Development Tasks

### Music Collection Creation
```bash
# Audio analysis for duration data
afinfo "path/to/audio.wav"

# File structure verification
ls -la XXX-collection-name/02-Individual-music/
```

### Documentation Management
- Always read `200-docs/knowledges/00-master-knowledge-base.md` before any major task
- Record insights in `200-docs/awareness/YYYYMMDD-title.md`
- Store work-in-progress in `working/YYYYMMDD-task-name.md`

### YouTube Content Optimization
- Use templates from `200-docs/knowledges/04-description-seo.md`
- Follow time format rules: `xx:xx` for <1hr, `x:xx:xx` for >1hr
- Always include accurate timestamps for video chapters

## 🎯 Key Business Logic

### Revolutionary Music Generation Technique
- **装飾語マシマシ技法**: Triple emotional descriptors `[peaceful, serene, tranquil]`
- **繰り返し強調**: Repetitive emphasis `gentle gentle gentle`, `slow slow slow`
- This creates unique, high-quality 8-bit music that's difficult to replicate

### Internal Circulation System
- **FROM THE構文**: Cross-collection promotion using "FROM THE EPIC [COLLECTION_NAME]" structure
- All content descriptions include links to other collections
- Creates powerful viewer retention and channel growth

### Content Scaling Strategy
- One master collection → 20+ individual tracks
- Each track becomes standalone content with SEO optimization
- Enables daily posting schedule from single production cycle

## 📊 Data Management

### Critical Data Sources
- **Master Knowledge Base**: `200-docs/knowledges/00-master-knowledge-base.md` - Always check first
- **Content Portfolio**: `200-docs/knowledges/02-content-portfolio.md` - Track all created content
- **Awareness Files**: Document all discoveries and improvements
- **Working Directory**: Temporary task files

### Time Data Accuracy
- Always verify actual file durations using `afinfo` command
- Cross-reference with awareness analysis files
- Maintain strict format consistency across all descriptions

## 🚨 Critical Requirements

### Before Any Task
1. Read master knowledge base for latest project state
2. Verify actual file structure and contents
3. Use standardized time formats
4. Follow established templates and workflows

### File Management
- Use `working/` for all temporary task files
- Never modify master knowledge files without verification
- Always include accurate timestamps in video descriptions
- Maintain consistent naming conventions

### Quality Assurance
- Verify URL accuracy before publishing
- Cross-check all numerical data with source files
- Ensure template compliance for brand consistency
- Test internal linking systems

## 🎵 Music Production Workflow

1. **Prompt Engineering**: Use established techniques from knowledge base
2. **Audio Generation**: Create WAV files following naming conventions
3. **Video Production**: Convert to MP4 with visual elements
4. **Description Creation**: Use templates with accurate timestamps
5. **SEO Optimization**: Apply hashtag strategies and internal linking
6. **Publishing**: Follow scheduled release pattern

## 📈 Success Metrics

- **10.8+ hours** of total content
- **216 tracks** across **9 completed collections**
- **26GB** project size
- Revolutionary music generation techniques with proven results
- Comprehensive knowledge management system for continuous improvement

## ⚠️ Important Notes

- This is a Japanese project with Kansai dialect communication preference
- All assistant responses should be in Kansai dialect
- Focus on practical, actionable support
- Maintain high quality standards established by proven techniques
- Always prioritize accuracy over speed in data handling

---

*This codebase represents a comprehensive YouTube content creation and management system with proven revolutionary techniques for AI music generation and content optimization.*