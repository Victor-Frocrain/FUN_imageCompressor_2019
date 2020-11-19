##
## EPITECH PROJECT, 2020
## imageCreator
## File description:
## imageCreator
##

NAME	=	imageCreator

SRC		=	src/Parser.cpp					\
			src/ImageCreatorException.cpp	\
			src/Decypher.cpp				\

MAIN	=	src/main.cpp

OBJ1	=	$(MAIN:%.cpp=%.o)

OBJ2	=	$(SRC:%.cpp=%.o)

CXXFLAGS=	-W -Wall -Wextra -Wshadow -I include/

LDFLAGS	=	-lsfml-graphics -lsfml-window -lsfml-system

CXX	=		g++

all:		$(NAME)

$(NAME):	$(OBJ1) $(OBJ2)
			$(CXX) -o $(NAME) $(OBJ1) $(OBJ2) $(LDFLAGS)

clean:
			$(RM) $(OBJ1) $(OBJ2)

fclean:		clean
			$(RM) $(NAME)

re:			fclean all

.PHONY:		clean fclean re
