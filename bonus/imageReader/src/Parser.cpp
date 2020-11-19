/*
** EPITECH PROJECT, 2020
** Parser
** File description:
** Parser.cpp
*/

#include "../include/Parser.hpp"
#include "../include/ImageReaderException.hpp"

Parser::Parser(const int &ac, char **&args)
{
    if (ac == 2) {
        _filePath = args[1];
    }
    else {
        throw ImageReaderException("Please, enter 2 arguments");
    }
}

Parser::~Parser()
{}

sf::Image Parser::openFile() const
{
    sf::Image image;

    if (!image.loadFromFile(_filePath)) {
        throw ImageReaderException("Cannot load the file.");
    }
    return image;
}