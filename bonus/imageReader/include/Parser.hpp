/*
** EPITECH PROJECT, 2020
** Parser
** File description:
** Parser.hpp
*/

#ifndef PARSER_HPP_
#define PARSER_HPP_

#include <string>
#include <SFML/Graphics.hpp>

class Parser {
public:
    Parser(const int &ac, char **&args);
    ~Parser();

    sf::Image openFile() const;

private:
    std::string _filePath;
};


#endif /* PARSER_HPP_ */
