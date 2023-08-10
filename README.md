# <Chess>

A command-line chess game for two players, written in Ruby. Try it on replit or clone the repo (requires
Ruby).

## About

Built as part of The Odin Project's Ruby on Rails course. This project in particular emphasized the use of
good object-oriented design and scalable classes.

During the build, I chose to treat special moves as "additional requirements" added to the main
functionality of the program. It was a good - though occasionally painful - lesson in the importance
of SOLID design.

## How to Play

On load, the game will print instructions. Type "help" to bring up the instructions again.

To make a standard move, choose a piece by typing its position in algebraic notation. Then choose its
destination.

To castle, type "castle." Unless you have castled before or your king has moved, you will be prompted
to choose short/kingside ("K") or long/queenside ("Q").

If you advance a pawn to its eighth rank, you will be prompted to choose to which piece you would like to
promote it: Queen ("Q"), Rook ("R"), Bishop ("B"), or Knight ("N").

To save your game, type "save." The option to load saved games will be available if any saves exist.

To resign or otherwise declare a stalemate, type "resign."

No illegal moves can be made, and all standard rules of chess regarding castling and en passant captures
apply.
