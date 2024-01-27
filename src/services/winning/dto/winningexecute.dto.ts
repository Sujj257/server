import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsNotEmpty,
  IsString,
  IsBoolean,
  IsInt,
  IsArray,
} from 'class-validator';

export class WinningExecuteDto {
  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    description: 'draw_id',
    example: 1,
  })
  draw_id: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'draw_date',
    example: '2023-01-01',
  })
  draw_date: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'first',
    example: '123',
  })
  first: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'second',
    example: '345',
  })
  second: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'third',
    example: '',
  })
  third: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'forth',
    example: '',
  })
  forth: string;

  @IsString()
  @ApiPropertyOptional({
    description: 'fifth',
    example: '',
  })
  fifth: string;

  @IsArray()
  @ApiPropertyOptional({
    description: 'sixth',
    example: ['235', '765'],
  })
  sixth: Array<number>;

  @IsBoolean()
  @ApiPropertyOptional({
    description: 'hidden_update',
    example: false,
  })
  hidden_update = false;
}
