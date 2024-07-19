# World Cup Database Project

This project employs PostgreSQL to manage and query data related to World Cup matches.

## Project Overview

This project includes:
- Automated insertion of data into PostgreSQL tables from a CSV file.
- SQL schema for creating the necessary database tables.
- Bash scripts to test and query the database.

## Database Schema

The database contains two main tables:
- `teams`: Stores information about the teams.
- `games`: Stores information about the matches.

### Tables

#### `teams`
| Column  | Type    | Description            |
|---------|---------|------------------------|
| team_id | INTEGER | Primary key            |
| name    | VARCHAR | Name of the team       |

#### `games`
| Column         | Type    | Description                       |
|----------------|---------|-----------------------------------|
| game_id        | INTEGER | Primary key                       |
| year           | INTEGER | Year of the game                  |
| round          | VARCHAR | Round of the game (e.g., Final)   |
| winner_id      | INTEGER | Foreign key referencing `teams`   |
| opponent_id    | INTEGER | Foreign key referencing `teams`   |
| winner_goals   | INTEGER | Goals scored by the winning team  |
| opponent_goals | INTEGER | Goals scored by the opponent team |

## Setup Instructions

1. Clone the repository:
    ```bash
    git clone https://github.com/danoman17/db-worldcup-postgresql.git
    cd db-worldcup-postgresql
    ```

2. Import the database schema and data:
    ```bash
    psql --username=freecodecamp --dbname=worldcup < worldcup.sql
    ```

3. Run the data insertion script:
    ```bash
    ./insert_data.sh
    ```

4. Test the database with predefined queries:
    ```bash
    ./queries.sh
    ```

## Bash Scripts

### `insert_data.sh`

This script reads the `games.csv` file and inserts data into the `teams` and `games` tables, ensuring that each team is only inserted once.

### `queries.sh`

This script runs a series of SQL queries to demonstrate various capabilities of the database, including:
- Total goals scored by winning teams.
- Total goals scored by all teams.
- Average goals per game.
- Games where the winning team scored more than two goals.
- Winners of specific tournaments.
- Teams that played in specific rounds.
- Unique winning teams.
- Champions over the years.
- Teams starting with specific letters.

## Conclusion

This project demonstrates the ability to design, implement, and manage a complex relational database in PostgreSQL. It showcases data modeling skills, knowledge of SQL, and understanding of database constraints and normalization.

Feel free to explore the database and modify it as needed for your purposes.

