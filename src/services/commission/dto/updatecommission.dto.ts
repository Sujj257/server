import { ApiProperty } from '@nestjs/swagger';
import { IsDecimal, IsNotEmpty, IsInt } from 'class-validator';

export class UpdateCommissionDto {
  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    description: 'account_id',
    example: 56,
  })
  account_id: number;

  @IsDecimal()
  @IsNotEmpty()
  @ApiProperty({
    description: 'abc',
    example: 1.0,
  })
  abc: number;

  @IsDecimal()
  @IsNotEmpty()
  @ApiProperty({
    description: 'abbcac',
    example: 1.0,
  })
  abbcac: number;

  @IsDecimal()
  @IsNotEmpty()
  @ApiProperty({
    description: 's_dear',
    example: 0,
  })
  s_dear: number;

  @IsDecimal()
  @IsNotEmpty()
  @ApiProperty({
    description: 's_box',
    example: 0,
  })
  s_box: number;
}
