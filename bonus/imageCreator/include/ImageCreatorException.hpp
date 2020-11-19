/*
** EPITECH PROJECT, 2020
** ImageCreator
** File description:
** ImageReader: ImageCreatorException.hpp
*/

#ifndef IMAGE_CREATOR_EXCEPTION_HPP_
#define IMAGE_CREATOR_EXCEPTION_HPP_

#include <exception>
#include <string>

class ImageCreatorException : public std::exception {
public:
    ImageCreatorException(const std::string &what);

    const char *what(void) const noexcept override;

private:
    const std::string _what;
};

#endif /* IMAGE_CREATOR_EXCEPTION_HPP_ */
