import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsInt, IsArray } from 'class-validator';

export class PurchaseBillDto {
  @IsInt()
  @IsNotEmpty()
  @ApiProperty({
    description: 'draw_id',
    example: 1,
  })
  draw_id: number;

  @IsArray()
  @IsNotEmpty()
  @ApiProperty({
    description: 'tickets',
    example: [
      {
        type: 'DEAR',
        number: '124',
        count: '10',
        c_amt: '50',
        d_amt: '20',
        customer: '',
      },
    ],
  })
  tickets: Array<TicketsDto>;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'p_date',
    example: '2023-03-05',
  })
  p_date: string;
}

export class TicketsDto {
  @IsString()
  @IsNotEmpty()
  type: string;

  @IsString()
  @IsNotEmpty()
  number: string;

  @IsString()
  @IsNotEmpty()
  count: string;

  @IsString()
  customer: string;
}
