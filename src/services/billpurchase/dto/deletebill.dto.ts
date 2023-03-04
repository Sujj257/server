import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty } from 'class-validator';

export class PurchaseDeleteDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'bill_id',
    example: '50000',
  })
  bill_id: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'ticket_id',
    example: 'null',
  })
  ticket_id: any;
}
