import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsInt, IsOptional } from 'class-validator';

export class SignupDto {
  @IsInt()
  @IsOptional()
  @ApiPropertyOptional({
    description: 'account_id',
    example: '56',
  })
  account_id!: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'username',
    example: '121',
  })
  username: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'password',
    example: '123',
  })
  password: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'privilage_level',
    example: '3',
  })
  privilage_level: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'daily_limit',
    example: '10000',
  })
  daily_limit: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'weekly_limit',
    example: '590000',
  })
  weekly_limit: string;
}
