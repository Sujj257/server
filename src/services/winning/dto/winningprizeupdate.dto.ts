import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsInt } from 'class-validator';

export class WinningPrizeUpdateDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    example: '98',
  })
  account_id: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    example: '56',
  })
  updated_by: string;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 5000,
  })
  dear_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 2000,
  })
  dear_2st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  dear_3st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  dear_4st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  dear_5st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  dear_6st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  abc_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  abbcac_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  box_same_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  box_both_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  box_both_2st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  box_shuffle_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    example: 0,
  })
  box_shuffle_2st_prize: number;
}
