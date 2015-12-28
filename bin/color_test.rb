#!/usr/bin/env ruby

require 'cherry_silt/color'

color_options = true

printf Color.parse("{RTe{dst\n", color_options)
printf Color.parse("{dTesting default{d\n", color_options)
printf Color.parse("{kTesting black{d\n", color_options)
printf Color.parse("{rTesting red{d\n", color_options)
printf Color.parse("{gTesting green{d\n", color_options)
printf Color.parse("{yTesting yellow{d\n", color_options)
printf Color.parse("{bTesting blue{d\n", color_options)
printf Color.parse("{mTesting magenta{d\n", color_options)
printf Color.parse("{cTesting cyan{d\n", color_options)
printf Color.parse("{wTesting white{d\n", color_options)
printf Color.parse("{KTesting bright_black{d\n", color_options)
printf Color.parse("{RTesting bright_red{d\n", color_options)
printf Color.parse("{GTesting bright_green{d\n", color_options)
printf Color.parse("{YTesting bright_yellow{d\n", color_options)
printf Color.parse("{BTesting bright_blue{d\n", color_options)
printf Color.parse("{MTesting bright_magenta{d\n", color_options)
printf Color.parse("{CTesting bright_cyan{d\n", color_options)
printf Color.parse("{WTesting bright_white{d\n", color_options)
printf Color.parse("}dTesting background_default{d\n", color_options)
printf Color.parse("}kTesting background_black{d\n", color_options)
printf Color.parse("}rTesting background_red{d\n", color_options)
printf Color.parse("}gTesting background_green{d\n", color_options)
printf Color.parse("}yTesting background_yellow{d\n", color_options)
printf Color.parse("}bTesting background_blue{d\n", color_options)
printf Color.parse("}nTesting background_magenta{d\n", color_options)
printf Color.parse("}cTesting background_cyan{d\n", color_options)
printf Color.parse("}wTesting background_white{d\n", color_options)
printf Color.parse("}w{RTesting red with background_white{d\n", color_options)