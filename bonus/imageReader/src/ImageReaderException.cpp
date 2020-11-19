/*
** EPITECH PROJECT, 2020
** ImageReader
** File description:
** ImageReader: ImageReaderException.cpp
*/

#include "../include/ImageReaderException.hpp"

ImageReaderException::ImageReaderException(const std::string &what):
    _what(what)
{};

const char *ImageReaderException::what(void) const noexcept
{
    return _what.c_str();
}
