/*
** EPITECH PROJECT, 2020
** Parser
** File description:
** Parser.cpp
*/

#include "../include/Parser.hpp"
#include "../include/ImageCreatorException.hpp"
#include <fstream>
#include <iostream>

Parser::Parser(const int &ac, char **&args)
{
    if (ac == 2) {
        _filePath = args[1];
    }
    else {
        throw ImageCreatorException("Please, enter 2 arguments");
    }
}

Parser::~Parser()
{}

bool Parser::parseNumber(const std::string &line, size_t &i, unsigned int &nb, const char delim) const
{
    std::string number = "";

    for (; i < line.length() && line[i] != delim; i++) {
        if (line[i] < '0' || line[i] > '9') {
            return false;
        }
        number += line[i];
    }
    if (number == "") {
        return false;
    }
    nb = std::stoi(number);
    i++;
    return true;
}

bool Parser::parseFile(const std::string &line, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int> &pixel) const
{
    size_t i = 0;

    if (line.length() == 0) {
        return false;
    }
    if (line[i] != '(') {
        return false;
    }
    else {
        i++;
    }
    if (!parseNumber(line, i, std::get<0>(pixel), ',')) {
        return false;
    }
    if (!parseNumber(line, i, std::get<1>(pixel), ')')) {
        return false;
    }
    if ((i + 2) >= line.length() || line[i] != ' ' || line[i + 1] != '(') {
        return false;
    }
    else {
        i += 2;
    }
    if (!parseNumber(line, i, std::get<2>(pixel), ',')) {
        return false;
    }
    if (!parseNumber(line, i, std::get<3>(pixel), ',')) {
        return false;
    }
    if (!parseNumber(line, i, std::get<4>(pixel), ')')) {
        return false;
    }
    return true;
}

std::vector<std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>> Parser::openFile() const
{
    std::vector<std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>> pixels;
    std::ifstream file;
    std::string line;

    file.open(_filePath);
    if (file.fail()) {
        throw ImageCreatorException("Cannot open " + _filePath + ".");
    }
    for (std::getline(file, line); line != ""; std::getline(file, line)) {
        std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int> pixel;
        if (!parseFile(line, pixel)) {
            throw ImageCreatorException("Wrong file format.");
        }
        else {
            pixels.push_back(pixel);
        }
    }
    file.close();
    return pixels;
}