#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# We truncate the tables so we can make as many test or re-insertion as we require
echo $($PSQL "TRUNCATE games, teams")

# we break down the fields of the csv file, so we can manipulate each item when doing insertions
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then
    # get team_id
    WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    
    # if not found
    if [[ -z $WINNER_TEAM_ID ]]
    then
      # insert team
      INSERT_TEAM_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")

      if [[ $INSERT_TEAM_WINNER_RESULT == "INSERT 0 1" ]]
      then
          echo Inserted into teams, $WINNER
      fi
      #we get new winner team_id
      WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    fi
  fi

  if [[ $OPPONENT != opponent ]]
  then
    # get team_id
    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    
    # if not found
    if [[ -z $OPPONENT_TEAM_ID ]]
    then
      # insert team
      INSERT_TEAM_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

      if [[ $INSERT_TEAM_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
          echo Inserted into teams, $OPPONENT
      fi
      #get new TEAM_ID
      OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    fi
  fi
done

# we break down the fields of the csv file, so we can manipulate each item when doing insertions
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then

    #get team_id winner and opponent
    WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER' ")

    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT' ")
    
    #insert into games table
    INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_TEAM_ID, $OPPONENT_TEAM_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    if [[ $INSERT_GAMES_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted, $WINNER vs $OPPONENT, game into games
    fi
  fi
done

 
