/*
** EPITECH PROJECT, 2020
** Decypher
** File description:
** Decypher.cpp
*/

#include "../include/Decypher.hpp"
#include "../include/ImageCreatorException.hpp"
#include <iostream>
#include <fstream>

Decypher::Decypher(const std::vector<std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>> &pixels) : _pixels(pixels)
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

void Decypher::createImage() const
{
    sf::Image image;

    unsigned int width = std::get<0>(_pixels[_pixels.size() - 1]) + 1;
    unsigned int height = std::get<1>(_pixels[_pixels.size() - 1]) + 1;
    image.create(width, height);
    for (size_t i = 0; i < _pixels.size(); i++) {
        sf::Color color = sf::Color(std::get<2>(_pixels[i]), std::get<3>(_pixels[i]), std::get<4>(_pixels[i]));
        image.setPixel(std::get<0>(_pixels[i]), std::get<1>(_pixels[i]), color);
    }
    saveImage(image);
}

void Decypher::saveImage(const sf::Image &image) const
{
    image.saveToFile(_destFile);
}