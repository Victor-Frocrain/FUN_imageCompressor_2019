/*
** EPITECH PROJECT, 2020
** imageReader
** File description:
** imageReader: main.cpp
*/

#include "../include/Parser.hpp"
#include "../include/ImageCreatorException.hpp"
#include "../include/Decypher.hpp"
#include <iostream>

int main(int ac, char **av)
{
    std::vector<std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>> pixels;

    try {
        Parser parser(ac, av);
        pixels = parser.openFile();
        Decypher creator(pixels);
        creator.CreateFile();
        creator.createImage();
    }
    catch (const ImageCreatorException &error) {
        std::cerr << error.what() << std::endl;
        return 84;
    }
    return 0;
}
