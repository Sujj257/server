import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty } from 'class-validator';

export class LoginDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'username',
    example: '111',
  })
  username: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'password',
    example: '111',
  })
  password: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'ipaddress',
    example: '192.168.1.1',
  })
  ipaddress: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'appversion',
    example: '3.7',
  })
  appversion: string;
}
