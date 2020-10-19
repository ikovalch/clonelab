function test_recalibrate()

    set_default_plot_settings();

    files = find_files(...
        'output/2020-08-microformation-voltage-curves', ...
        'diagnostic_test');

    file = files{1};

    tbl = readtable(file);

    voltage = tbl.voltage;
    capacity = tbl.charge_capacity;

    [Un, Up] = get_electrode_models('original');
    result = run_esoh(tbl, Un, Up);

    [Un_recal, Up_recal] = recalibrate(voltage, capacity, result.Xt, ...
                            Un, Up);
    result_recal = run_esoh(tbl, Un_recal, Up_recal);


    fh = figure;

    line(result.ful.Q, result.ful.V, ...
        'LineWidth', 2, ...
        'DisplayName', 'Model', ...
        'Color', 'k', ...
        'LineStyle', ':');

    line(result_recal.ful.Q, result_recal.ful.V, ...
        'LineWidth', 2, ...
        'DisplayName', 'Model (Recal)', ...
        'Color', 'k', ...
        'LineStyle', '--');

    line(result.orig.Q, result.orig.V, ...
        'LineWidth', 2, ...
        'Color', 'k', ...
        'LineStyle', '-', ...
        'DisplayName', 'Data')

    line(result.pos.Q, result.pos.V, ...
        'LineWidth', 2, ...
        'Color', 'b', ...
        'DisplayName', 'POS');

    line(result.neg.Q, result.neg.V, ...
        'LineWidth', 2, ...
        'Color', 'r', ...
        'DisplayName', 'NEG');

    line(result_recal.pos.Q, result_recal.pos.V, ...
        'LineWidth', 2, ...
        'Color', 'b', ...
        'LineStyle', '--', ...
        'DisplayName', 'POS (Recal)');

    line(result_recal.neg.Q, result_recal.neg.V, ...
        'LineWidth', 2, ...
        'Color', 'r', ...
        'LineStyle', '--', ...
        'DisplayName', 'NEG (Recal)');

    legend show
    xlabel('Q');
    ylabel('V');


    fh = figure;

    line(result.ful.Q, result.ful.dVdQ, ...
        'LineWidth', 2, ...
        'DisplayName', 'Model', ...
        'LineStyle', ':', ...
        'Color', 'k');

    line(result_recal.ful.Q, result_recal.ful.dVdQ, ...
        'LineWidth', 2, ...
        'DisplayName', 'Model (Recal)', ...
        'LineStyle', '--', ...
        'Color', 'k');

    line(result.orig.Q, result.orig.dVdQ, ...
        'LineWidth', 2, ...
        'Color', 'k', ...
        'LineStyle', '-', ...
        'DisplayName', 'Data')

    line(result.pos.Q, result.pos.dVdQ, ...
        'LineWidth', 2, ...
        'Color', 'b', ...
        'DisplayName', 'POS');

    line(result.neg.Q, result.neg.dVdQ, ...
        'LineWidth', 2, ...
        'Color', 'r', ...
        'DisplayName', 'NEG');

    line(result_recal.pos.Q, result_recal.pos.dVdQ, ...
        'LineWidth', 2, ...
        'Color', 'b', ...
        'LineStyle', '--', ...
        'DisplayName', 'POS (Recal)');

    line(result_recal.neg.Q, result_recal.neg.dVdQ, ...
        'LineWidth', 2, ...
        'Color', 'r', ...
        'LineStyle', '--', ...
        'DisplayName', 'NEG (Recal)');

    legend show
    xlabel('Q');
    ylabel('dV/dQ');
    ylim([0 1]);

    keyboard

end
