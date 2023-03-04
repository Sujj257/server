import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsBoolean } from 'class-validator';

export class UpdateProfileDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'account_id',
    example: '98',
  })
  account_id: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'password',
    example: 'null',
  })
  password: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'privilage_level',
    example: 'null',
  })
  privilage_level: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'daily_limit',
    example: 'null',
  })
  daily_limit: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'weekly_limit',
    example: 'null',
  })
  weekly_limit: string;

  @IsBoolean()
  @ApiPropertyOptional({
    description: 'block',
    example: false,
  })
  block = false;
}
