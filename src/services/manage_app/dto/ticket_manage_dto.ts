import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsBoolean, IsOptional, IsArray } from 'class-validator';

export class ManageTicketDto {

    @IsString()
    @IsNotEmpty()
    @ApiProperty({
        description: 'draw_id',
        example: '1',
    })
    draw_id: string;

    @IsArray()
    @IsOptional()
    @ApiProperty({
        description: 'valuelist',
        example: '{"column_name":"single_a","column_value":"2000"}',
    })
    value_lists: Array<TicketUpdateDto>;


    @IsBoolean()
    @IsNotEmpty()
    @ApiProperty({
        description: 'isedit',
        example: true,
    })
    isedit = true;

}


export class TicketUpdateDto {
    @IsString()
    column_name: string;

    @IsString()
    column_value: string;
}