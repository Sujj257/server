import { ApiProperty } from '@nestjs/swagger';
import { IsDecimal, IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class UpdateCommissionDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'account_id',
    example: 56,
  })
  account_id: string;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({
    description: 'abc',
    example: 1.0,
  })
  abc: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({
    description: 'abbcac',
    example: 1.0,
  })
  abbcac: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({
    description: 's_dear',
    example: 0,
  })
  s_dear: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({
    description: 's_box',
    example: 0,
  })
  s_box: number;
}
