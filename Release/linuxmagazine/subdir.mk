################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../linuxmagazine/test.cpp 

OBJS += \
./linuxmagazine/test.o 

CPP_DEPS += \
./linuxmagazine/test.d 


# Each subdirectory must supply rules for building sources it contributes
linuxmagazine/%.o: ../linuxmagazine/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


