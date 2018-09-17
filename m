Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37554 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbeIQS7w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Sep 2018 14:59:52 -0400
Received: by mail-wm1-f45.google.com with SMTP id n11-v6so9610666wmc.2
        for <linux-integrity@vger.kernel.org>; Mon, 17 Sep 2018 06:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
 <20180916191605.GB7473@linux.intel.com>
In-Reply-To: <20180916191605.GB7473@linux.intel.com>
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Mon, 17 Sep 2018 10:32:18 -0300
Message-ID: <CAN19L9HFSkPfrRjDKZZiNXW+rXpV89v9ua1p_r4qmO8pQHfKiA@mail.gmail.com>
Subject: Re: Question about the TPM driver
To: jarkko.sakkinen@linux.intel.com
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

El dom., 16 sept. 2018 a las 16:16, Jarkko Sakkinen
(<jarkko.sakkinen@linux.intel.com>) escribio:
> I understand your concerns but without a concrete workload there is no
> problem with this behavior.

IMHO it's a bit excessive to allocate 4k to end up storing than 100
bytes. Beyond that, it's a pretty big gotcha for someone who's writing
software which talks to the driver :)
