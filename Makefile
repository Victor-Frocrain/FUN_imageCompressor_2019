##
## EPITECH PROJECT, 2020
## Makefile
## File description:
## Makefile
##

SRC			=	project/src/Functions.hs

SRC_MAIN	=	project/app/imageCompressor.hs

NAME		=	imageCompressor

all:		$(NAME)

$(NAME):
		ghc $(SRC_MAIN) $(SRC)
		cp project/app/$(NAME) ./

clean:
		rm -f project/app/*.hi project/app/*.o project/src/*.hi project/src/*.o

fclean:		clean
		rm -f $(NAME)
		rm -f project/app/$(NAME)

re:		fclean all
