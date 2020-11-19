/*
** EPITECH PROJECT, 2020
** Decypher
** File description:
** Decypher.hpp
*/

#ifndef DECYPHER_HPP_
#define DECYPHER_HPP_

#include <SFML/Graphics.hpp>

class Decypher {
public:
    Decypher(const std::vector<std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>> &pixels);
    ~Decypher();

    void CreateFile();
    void createImage() const;
    void saveImage(const sf::Image &image) const;

private:
    std::vector<std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>> _pixels;
    sf::Image _image;
    std::string _destFile;
};

#endif /* DECYPHER_HPP_ */
