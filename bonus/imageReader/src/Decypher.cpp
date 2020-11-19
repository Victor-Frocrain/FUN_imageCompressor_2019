/*
** EPITECH PROJECT, 2020
** Decypher
** File description:
** Decypher.cpp
*/

#include "../include/Decypher.hpp"
#include "../include/ImageReaderException.hpp"
#include <iostream>
#include <fstream>

Decypher::Decypher(const sf::Image &image) : _image(image)
{

}

Decypher::~Decypher()
{

}

void Decypher::CreateFile()
{
    std::fstream file;
    std::string answer = "n";

    while (answer == "n") {
        std::cout << "Choose a destination path: ";
        std::getline(std::cin, _destFile);
        file.open(_destFile);
        if (!file.fail()) {
            file.close();
            std::cerr << "This file already exists. Do you want to replace it ? (y/n): ";
            for (std::getline(std::cin, answer); answer != "y" && answer != "n"; std::getline(std::cin, answer)) {
                std::cout << "Wrong answer, please try again: ";
            }
        }
        else {
            break;
        }
    }
}

void Decypher::ReadPixels() const
{
    sf::Vector2u size = _image.getSize();
    sf::Color color;
    std::ofstream stream;
    std::string content = "";

    stream.open(_destFile);
    if (stream.fail()) {
        throw ImageReaderException("Cannot create or open the file" + _destFile + ".");
    }
    for (unsigned int y = 0; y < size.y; y++) {
        for (unsigned int x = 0; x < size.x; x++) {
            color = _image.getPixel(x, y);
            content += "(" + std::to_string(x) + "," + std::to_string(y) + ") (" + std::to_string(color.r) + "," + std::to_string(color.g) + "," + std::to_string(color.b) + ")\n";
        }
    }
    WriteValues(stream, content);
    stream.close();
}

void Decypher::WriteValues(std::ofstream &stream, const std::string &content) const
{
    stream.write(content.c_str(), content.length());
}