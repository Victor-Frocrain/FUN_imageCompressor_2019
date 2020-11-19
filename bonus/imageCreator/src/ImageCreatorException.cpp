/*
** EPITECH PROJECT, 2020
** ImageCreator
** File description:
** ImageCreator: ImageCreatorException.cpp
*/

#include "../include/ImageCreatorException.hpp"

ImageCreatorException::ImageCreatorException(const std::string &what):
    _what(what)
{};

const char *ImageCreatorException::what(void) const noexcept
{
    return _what.c_str();
}
