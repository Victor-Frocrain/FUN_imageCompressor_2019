##
## EPITECH PROJECT, 2020
## bonus
## File description:
## bonus
##

NAME	=	../lib_arcade_SFML.so

SRC		=	src/SFML.cpp					\
			../../src/AEntity.cpp			\
			../../src/Entity.cpp			\
			../../src/ArcadeException.cpp	\

OBJ		=	$(SRC:%.cpp=%.o)

CXXFLAGS=	-W -Wall -Wextra -Wshadow -std=c++11 -I include/ -I ../../include -fPIC

LDFLAGS	=	-shared -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

CXX	=		g++

all:		$(NAME)

$(NAME):	$(OBJ)
			$(CXX) -o $(NAME) $(OBJ) $(LDFLAGS)

clean:
			$(RM) $(OBJ)

fclean:		clean
			$(RM) $(NAME)

re:			fclean all

.PHONY:		clean fclean re
