/*
** EPITECH PROJECT, 2020
** ImageReader
** File description:
** ImageReader: ImageReaderException.hpp
*/

#ifndef IMAGE_READER_EXCEPTION_HPP_
#define IMAGE_READER_EXCEPTION_HPP_

#include <exception>
#include <string>

class ImageReaderException : public std::exception {
public:
    ImageReaderException(const std::string &what);

    const char *what(void) const noexcept override;

private:
    const std::string _what;
};

#endif /* IMAGE_READER_EXCEPTION_HPP_ */
