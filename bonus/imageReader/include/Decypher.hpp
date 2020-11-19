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
    Decypher(const sf::Image &image);
    ~Decypher();

    void CreateFile();
    void ReadPixels() const;
    void WriteValues(std::ofstream &stream, const std::string &content) const;

private:
    sf::Image _image;
    std::string _destFile;
};

#endif /* DECYPHER_HPP_ */
