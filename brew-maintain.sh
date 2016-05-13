#!/bin/sh

brew update;
brew cleanup;
brew cask cleanup;
brew upgrade;
brew cleanup;
brew cask cleanup;