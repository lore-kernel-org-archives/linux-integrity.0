Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55579 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeIEWDi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 18:03:38 -0400
Received: by mail-wm0-f48.google.com with SMTP id f21-v6so8797365wmc.5
        for <linux-integrity@vger.kernel.org>; Wed, 05 Sep 2018 10:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
 <20180905173057.GB11368@linux.intel.com>
In-Reply-To: <20180905173057.GB11368@linux.intel.com>
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Wed, 5 Sep 2018 14:32:14 -0300
Message-ID: <CAN19L9FkwkS_azU2Nx3L=7cTZn4F_Ac78g8-AUO1mmW7Wqo3XA@mail.gmail.com>
Subject: Re: caps file showing wrong TCG version?
To: jarkko.sakkinen@linux.intel.com
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

El mie., 5 sept. 2018 a las 14:30, Jarkko Sakkinen
(<jarkko.sakkinen@linux.intel.com>) escribio:
> It is clearly a TPM 1.2 chip as it talks TPM 1.x protocol. The caps file
> is only shown for TPM 1.x devices and it uses TPM_ORD_GET_CAP command,
> which is part of the TPM 1.x protocol.

Yes, I had realized that. My mistake.
