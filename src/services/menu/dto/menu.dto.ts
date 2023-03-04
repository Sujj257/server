import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsBoolean, IsOptional } from 'class-validator';

export class MenuDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'account_id',
    example: 'null',
  })
  account_id: any;

  @IsBoolean()
  @IsOptional()
  @ApiPropertyOptional({
    description: 'one_pm',
    example: true,
  })
  one_pm = true;

  @IsBoolean()
  @IsOptional()
  @ApiPropertyOptional({
    description: 'three_pm',
    example: true,
  })
  three_pm = true;

  @IsBoolean()
  @IsOptional()
  @ApiPropertyOptional({
    description: 'six_pm',
    example: true,
  })
  six_pm = true;

  @IsBoolean()
  @IsOptional()
  @ApiPropertyOptional({
    description: 'eight_pm',
    example: true,
  })
  eight_pm = true;

  @IsBoolean()
  @IsOptional()
  @ApiPropertyOptional({
    description: 'isedit',
    example: false,
  })
  isedit = false;
}
