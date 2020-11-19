/*
** EPITECH PROJECT, 2020
** imageReader
** File description:
** imageReader: main.cpp
*/

#include "../include/Parser.hpp"
#include "../include/ImageReaderException.hpp"
#include "../include/Decypher.hpp"
#include <iostream>

int main(int ac, char **av)
{
    sf::Image image;

    try {
        Parser parser(ac, av);
        image = parser.openFile();
        Decypher decypher(image);
        decypher.CreateFile();
        decypher.ReadPixels();
    }
    catch (const ImageReaderException &error) {
        std::cerr << error.what() << std::endl;
        return 84;
    }
    return 0;
}
