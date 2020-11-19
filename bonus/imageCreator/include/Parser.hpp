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

    std::vector<std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>> openFile() const;
    bool parseFile(const std::string &line, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int> &pixel) const;
    bool parseNumber(const std::string &line, size_t &i, unsigned int &nb, const char delim) const;

private:
    std::string _filePath;
};


#endif /* PARSER_HPP_ */
