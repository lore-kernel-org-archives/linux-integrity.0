Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754011AbdKJUxB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Nov 2017 15:53:01 -0500
Date: Fri, 10 Nov 2017 13:53:00 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20171023132346.jbqgokwv3ah2oqjo@linux.intel.com>
 <20171023134515.56siz3m6lhrhnovv@rhwork>
 <20171024135123.uqail7olnespun4k@linux.intel.com>
 <20171024145706.na56ff34w5agzo2t@rhwork>
 <20171024160725.r6kj452jdzpkbb6o@linux.intel.com>
 <8f4df9a9-c8cd-832f-4c3f-5305fabab7a8@debian.org>
 <0a6e4771-f871-b3ca-b5b0-26dbd9efa8b1@debian.org>
 <20171110002820.wtfvb3tv5fcjqecu@localhost.localdomain>
 <20171110070738.ki5xie4z7yql77fk@localhost.localdomain>
 <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri Nov 10 17, Laurent Bigonville wrote:
>Le 10/11/17 a 08:07, Jerry Snitselaar a ecrit :
>>On Thu Nov 09 17, Jerry Snitselaar wrote:
>>>On Thu Nov 09 17, Laurent Bigonville wrote:
>>>>Le 09/11/17 a 01:04, Laurent Bigonville a ecrit :
>>>>>
>>>>>
>>>>>Le 24/10/17 a 18:07, Jarkko Sakkinen a ecrit :
>>>>>>On Tue, Oct 24, 2017 at 07:57:06AM -0700, Jerry Snitselaar wrote:
>>>>>>>On Tue Oct 24 17, Jarkko Sakkinen wrote:
>>>>>>>>On Mon, Oct 23, 2017 at 06:45:15AM -0700, Jerry Snitselaar wrote:
>>>>>>>>>On Mon Oct 23 17, Jarkko Sakkinen wrote:
>>>>>>>>>>On Sat, Oct 21, 2017 at 10:53:55AM +0200, Laurent 
>>>>>>>>>>Bigonville wrote:
>>>>>>>>>>>Le 14/10/17 a 10:13, Jerry Snitselaar a ecrit :
>>>>>>>>>>>>On Wed Sep 06 17, Jarkko Sakkinen wrote:
>>>>>>>>>>>>>On Fri, Sep 01, 2017 at 02:10:18PM +0200, 
>>>>>>>>>>>>>Laurent Bigonville wrote:
>>>>>>>>>>>>>>Le 31/08/17 a 18:40, Jerry Snitselaar a ecrit :
>>>>>>>>>>>>>>>On Thu Aug 31 17, Alexander.Steffen@infineon.com wrote:
>>>>>>>>>>>>>>>>>Le 29/08/17 a 18:35, Laurent Bigonville a ecrit :
>>>>>>>>>>>>>>>>>>Le 29/08/17 a 18:00, 
>>>>>>>>>>>>>>>>>>Alexander.Steffen@infineon.com a 
>>>>>>>>>>>>>>>>>>ecrit :
>>>>>>>>>>>>>>>>>>>>An idea how to troubleshoot this?
>>>>>>>>>>>>>>>>>>>Can you run git bisect on the changes between 4.11 and
>>>>>>>>>>>>>>4.12, so that
>>>>>>>>>>>>>>>>>>>we find the offending commit? It is probably sufficient
>>>>>>>>>>>>>>to limit the
>>>>>>>>>>>>>>>>>>>search to commits that touch 
>>>>>>>>>>>>>>>>>>>something in drivers/char/tpm.
>>>>>>>>>>>>>>>>>>I'll try and keep you posted.
>>>>>>>>>>>>>>>>>OK I've been able to bisect the 
>>>>>>>>>>>>>>>>>problem and the bad commit is:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>e6aef069b6e97790cb127d5eeb86ae9ff0b7b0e3 
>>>>>>>>>>>>>>>>>is the first bad commit
>>>>>>>>>>>>>>>>>commit e6aef069b6e97790cb127d5eeb86ae9ff0b7b0e3
>>>>>>>>>>>>>>>>>Author: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>>>>>>>>>>>>>>Date:   Mon Mar 27 08:46:04 2017 -0700
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      tpm_tis: convert to using locality callbacks
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      This patch converts tpm_tis to 
>>>>>>>>>>>>>>>>>use of the new tpm class ops
>>>>>>>>>>>>>>>>>      request_locality, and relinquish_locality.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      With the move to using the 
>>>>>>>>>>>>>>>>>callbacks, release_locality is
>>>>>>>>>>>>>>>>>changed so
>>>>>>>>>>>>>>>>>      that we now release the locality even if there is no
>>>>>>>>>>>>>>>>>request pending.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      This required some changes to the tpm_tis_core_init
>>>>>>>>>>>>>>code path to
>>>>>>>>>>>>>>>>>      make sure locality is requested when needed:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>        - tpm2_probe code path will end up calling
>>>>>>>>>>>>>>>>>request/release through
>>>>>>>>>>>>>>>>>          callbacks, so request_locality prior to
>>>>>>>>>>>>>>tpm2_probe not needed.
>>>>>>>>>>>>>>>>>        - probe_itpm makes calls to 
>>>>>>>>>>>>>>>>>tpm_tis_send_data which no
>>>>>>>>>>>>>>>>>longer calls
>>>>>>>>>>>>>>>>>          request_locality, so add 
>>>>>>>>>>>>>>>>>request_locality prior to
>>>>>>>>>>>>>>>>>tpm_tis_send_data
>>>>>>>>>>>>>>>>>          calls. Also drop 
>>>>>>>>>>>>>>>>>release_locality call in middleof
>>>>>>>>>>>>>>>>>probe_itpm, and
>>>>>>>>>>>>>>>>>          keep locality until 
>>>>>>>>>>>>>>>>>release_locality called at end of
>>>>>>>>>>>>>>>>>probe_itpm.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      Cc: Peter Huewe <peterhuewe@gmx.de>
>>>>>>>>>>>>>>>>>      Cc: Jarkko Sakkinen 
>>>>>>>>>>>>>>>>><jarkko.sakkinen@linux.intel.com>
>>>>>>>>>>>>>>>>>      Cc: Jason Gunthorpe 
>>>>>>>>>>>>>>>>><jgunthorpe@obsidianresearch.com>
>>>>>>>>>>>>>>>>>      Cc: Marcel Selhorst <tpmdd@selhorst.net>
>>>>>>>>>>>>>>>>>      Signed-off-by: Jerry Snitselaar 
>>>>>>>>>>>>>>>>><jsnitsel@redhat.com>
>>>>>>>>>>>>>>>>>      Reviewed-by: Jarkko Sakkinen
>>>>>>>>>>>>>><jarkko.sakkinen@linux.intel.com>
>>>>>>>>>>>>>>>>>Tested-by: Jarkko Sakkinen 
>>>>>>>>>>>>>>>>><jarkko.sakkinen@linux.intel.com>
>>>>>>>>>>>>>>>>>      Signed-off-by: Jarkko Sakkinen
>>>>>>>>>>>>>><jarkko.sakkinen@linux.intel.com>
>>>>>>>>>>>>>>>>>:040000 040000 70234365da69959d47076ebb40c8d17f520c3e44
>>>>>>>>>>>>>>>>>72f21b446e45ea1003de75902b0553deb99157fd M drivers
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>I've looked again at the code in 
>>>>>>>>>>>>>>>>question, but could not find
>>>>>>>>>>>>>>>>anything that is obviously wrong there. Locality is now
>>>>>>>>>>>>>>>>requested/released at slightly different 
>>>>>>>>>>>>>>>>points in the process than
>>>>>>>>>>>>>>>>before, but that's it. It does not seem 
>>>>>>>>>>>>>>>>to cause problems with the
>>>>>>>>>>>>>>>>majority of TPMs, since you are the first to report any, so
>>>>>>>>>>>>>>maybe it
>>>>>>>>>>>>>>>>is a quirk that only affects this device.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>Perhaps Jerry can help, since this is his change?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>Alexander
>>>>>>>>>>>>>>>Getting some caffeine in me, and starting 
>>>>>>>>>>>>>>>to take a look. Adding
>>>>>>>>>>>>>>>Jarkko as well since this might involve 
>>>>>>>>>>>>>>>the general locality changes.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>Laurent, if I send you a patch with some 
>>>>>>>>>>>>>>>debugging code added, would
>>>>>>>>>>>>>>>you be able to run it on that system? I 
>>>>>>>>>>>>>>>wasn't running into issues
>>>>>>>>>>>>>>>on the system I had with a 1.2 device, but 
>>>>>>>>>>>>>>>I no longer have access
>>>>>>>>>>>>>>>to it. I'll see if I can find one in our 
>>>>>>>>>>>>>>>labs and reproduce it there.
>>>>>>>>>>>>>>Yes I should be able to do that
>>>>>>>>>>>>>Any findings?
>>>>>>>>>>>>>
>>>>>>>>>>>>>/Jarkko
>>>>>>>>>>>>Okay, finally getting back to this. Looking at 
>>>>>>>>>>>>the code it isn't clear
>>>>>>>>>>>>to me
>>>>>>>>>>>>why the change is causing this. So while I stare 
>>>>>>>>>>>>at this some more
>>>>>>>>>>>>Laurent
>>>>>>>>>>>>could you reproduce it with this patch so I can 
>>>>>>>>>>>>see what the status and
>>>>>>>>>>>>access registers look like? Does anyone else on 
>>>>>>>>>>>>here happen to have a
>>>>>>>>>>>>Sinosun
>>>>>>>>>>>>tpm device? The systems I have access to with 
>>>>>>>>>>>>TPM1.2 devices don't have
>>>>>>>>>>>>this
>>>>>>>>>>>>issue.
>>>>>>>>>>>>
>>>>>>>>>>>>--8<--
>>>>>>>>>>>>
>>>>>>>>>>>>diff --git a/drivers/char/tpm/tpm_tis_core.c
>>>>>>>>>>>>b/drivers/char/tpm/tpm_tis_core.c
>>>>>>>>>>>>index fdde971bc810..7d60a7e4b50a 100644
>>>>>>>>>>>>--- a/drivers/char/tpm/tpm_tis_core.c
>>>>>>>>>>>>+++ b/drivers/char/tpm/tpm_tis_core.c
>>>>>>>>>>>>@@ -258,6 +258,7 @@ static int 
>>>>>>>>>>>>tpm_tis_send_data(struct tpm_chip *chip,
>>>>>>>>>>>>const u8 *buf, size_t len)
>>>>>>>>>>>>     int rc, status, burstcnt;
>>>>>>>>>>>>     size_t count = 0;
>>>>>>>>>>>>     bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
>>>>>>>>>>>>+    u8 access;
>>>>>>>>>>>>
>>>>>>>>>>>>     status = tpm_tis_status(chip);
>>>>>>>>>>>>     if ((status & TPM_STS_COMMAND_READY) == 0) {
>>>>>>>>>>>>@@ -292,6 +293,11 @@ static int 
>>>>>>>>>>>>tpm_tis_send_data(struct tpm_chip *chip,
>>>>>>>>>>>>const u8 *buf, size_t len)
>>>>>>>>>>>>         }
>>>>>>>>>>>>         status = tpm_tis_status(chip);
>>>>>>>>>>>>         if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
>>>>>>>>>>>>+            rc = tpm_tis_read8(priv, 
>>>>>>>>>>>>TPM_ACCESS(priv->locality),
>>>>>>>>>>>>&access);
>>>>>>>>>>>>+            if (rc < 0)
>>>>>>>>>>>>+                dev_info(&chip->dev, 
>>>>>>>>>>>>"TPM_STS_DATA_EXPECT == 0: read
>>>>>>>>>>>>failure TPM_ACCESS(%d)\n", priv->locality);
>>>>>>>>>>>>+            else
>>>>>>>>>>>>+                dev_info(&chip->dev, 
>>>>>>>>>>>>"TPM_STS_DATA_EXPECT == 0:
>>>>>>>>>>>>locality: %d status: %x access: %x\n", 
>>>>>>>>>>>>priv->locality, status, access);
>>>>>>>>>>>>             rc = -EIO;
>>>>>>>>>>>>             goto out_err;
>>>>>>>>>>>>         }
>>>>>>>>>>>>@@ -309,6 +315,11 @@ static int 
>>>>>>>>>>>>tpm_tis_send_data(struct tpm_chip *chip,
>>>>>>>>>>>>const u8 *buf, size_t len)
>>>>>>>>>>>>     }
>>>>>>>>>>>>     status = tpm_tis_status(chip);
>>>>>>>>>>>>     if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
>>>>>>>>>>>>+        rc = tpm_tis_read8(priv, 
>>>>>>>>>>>>TPM_ACCESS(priv->locality), &access);
>>>>>>>>>>>>+        if (rc < 0)
>>>>>>>>>>>>+            dev_info(&chip->dev, 
>>>>>>>>>>>>"TPM_STS_DATA_EXPECT != 0: read
>>>>>>>>>>>>failure TPM_ACCESS(%d)\n", priv->locality);
>>>>>>>>>>>>+        else
>>>>>>>>>>>>+            dev_info(&chip->dev, 
>>>>>>>>>>>>"TPM_STS_DATA_EXPECT != 0: locality:
>>>>>>>>>>>>%d status: %x access: %x\n", priv->locality, status, access);
>>>>>>>>>>>>         rc = -EIO;
>>>>>>>>>>>>         goto out_err;
>>>>>>>>>>>>     }
>>>>>>>>>>>Please find here the dmesg output of the patched kernel
>>>>>>>>>>At least 0xff is corrupted value in senseful way. 
>>>>>>>>>>CPU fills the read
>>>>>>>>>>with ones for example for unaligned bus read. See 
>>>>>>>>>>table 19 in PC client
>>>>>>>>>>spec. This can happen when you do unaligned read for example.
>>>>>>>>>>
>>>>>>>>>>Maybe TPM is unreachable i.e. powered off. Bit busy 
>>>>>>>>>>with stuff ATM but
>>>>>>>>>>would probably make sense to compare that 0x81 to 
>>>>>>>>>>table 18 in the same
>>>>>>>>>>spec.
>>>>>>>>>>
>>>>>>>>>>/Jarkko
>>>>>>>>>0x81 is saying the access register status is valid, 
>>>>>>>>>and the locality
>>>>>>>>>is not active. That first bit means A Dynamic OS has 
>>>>>>>>>not been previously
>>>>>>>>>established on the platform. Normally we would see 
>>>>>>>>>0xa1, which would
>>>>>>>>>mean valid register status, and the locality is active.
>>>>>>>>I think the important thing to note here is that STS has 
>>>>>>>>bits set that
>>>>>>>>should never be set. So we can conclude that TPM might be either
>>>>>>>>
>>>>>>>>1. Powered off
>>>>>>>>2. In some transition state?
>>>>>>>>
>>>>>>>>/Jarkko
>>>>>>>If it was powered off would we be getting a valid read 
>>>>>>>from the access
>>>>>>>register?
>>>>>>I think there is no universal answer to that :-)
>>>>>>
>>>>>>Maybe adding a extra delay would be next test to make? If for random
>>>>>>reason it is in-between states...
>>>>>Any more ideas?
>>>>>
>>>>>The chip is definitely in a weird state :/ I tried several 
>>>>>ways to reset the chip (windows, tpm-tools,...).
>>>>>
>>>>>I've been able to reset the chip via the bios (which now shows 
>>>>>unowned) but chip is still locked apparently.
>>>>>
>>>>>But still with < 4.12 I'm able to get /some/ information 
>>>>>Public EK, PCR,... out of the chip so it's not completely 
>>>>>broken...
>>>>
>>>>OK correction the TPM is now unlocked (I let the computer 
>>>>running for more than 24h with nothing accessing the TPM) and 
>>>>with 4.9 I've been able to take the ownership again.
>>>>
>>>>Under 4.12 I still have the same errors as mentioned originally
>>>
>>>Hi Laurent,
>>>
>>>Would it be possible for you to run ftrace from boot with the 
>>>following kernel parameters:
>>>
>>>ftrace=function_graph ftrace_filter=tpm*
>>>
>>
>>actually 'ftrace=function_graph 
>>ftrace_filter=tpm*,*locality,wait_for_tpm_stat' would be better
>>
>>>and then send me the results of 'cat /sys/kernel/debug/tracing/trace' ?
>Here you are.

Thank you Laurent.

A few interesting things here:

># tracer: function_graph
>#
># CPU  DURATION                  FUNCTION CALLS
># |     |   |                     |   |   |   |
>  1)   4.510 us    |  tpm_init();
>  1)               |  tpm_tis_pnp_init() {
>  1)               |    tpm_tis_init.part.3() {
>  1)               |      tpm_tis_core_init() {
>  1)               |        tpmm_chip_alloc() {
>  1)   3.935 us    |          tpm_chip_alloc();
>  1)   4.787 us    |        }
>  1)   0.199 us    |        tpm_tcg_read_bytes();
>  1)   0.217 us    |        tpm_tcg_read32();
>  1)   0.117 us    |        tpm_tcg_write32();
>  1)               |        tpm2_probe() {
>  1)               |          tpm_transmit_cmd() {
>  1)               |            tpm_transmit() {
>  1)               |              request_locality() {
>  1)               |                check_locality() {
>  1)   0.045 us    |                  tpm_tcg_read_bytes();
>  1)   1.708 us    |                }
>  1)   2.077 us    |              }


So it goes request locality, does check to see if the locality
is already active and it is, so doesn't go through the process
of requesting the locality.


>  1)   0.168 us    |              tpm2_prepare_space();
>  1)               |              tpm_tis_send() {
>  1)               |                tpm_tis_send_main() {
>  1)               |                  tpm_tis_send_data() {
>  1)   0.045 us    |                    tpm_tcg_read_bytes();
>  1)   0.044 us    |                    tpm_tcg_read32();
>  1)   1.723 us    |                    tpm_tcg_write_bytes();
>  1)               |                    wait_for_tpm_stat() {
>  1)               |                      tpm_tis_status() {
>  1)   0.042 us    |                        tpm_tcg_read_bytes();
>  1)   5.163 us    |                      }
>  1)               |                      tpm_tis_status() {
>  1)   0.167 us    |                        tpm_tcg_read_bytes();
>  1)   2.182 us    |                      }
>  1)               |                      tpm_tis_status() {
>  1)   0.194 us    |                        tpm_tcg_read_bytes();
>  1)   2.452 us    |                      }
>  1) * 30406.24 us |                    }
>  1)   0.088 us    |                    tpm_tcg_read_bytes();
>  1)   0.123 us    |                    tpm_tcg_write_bytes();
>  1)               |                    wait_for_tpm_stat() {
>  1)               |                      tpm_tis_status() {
>  1)   0.084 us    |                        tpm_tcg_read_bytes();
>  1)   1.940 us    |                      }
>  1)               |                      tpm_tis_status() {
>  1)   0.170 us    |                        tpm_tcg_read_bytes();
>  1)   2.217 us    |                      }
>  1) * 16000.74 us |                    }
>  1)   0.084 us    |                    tpm_tcg_read_bytes();
>  1) * 46425.66 us |                  }
>  1)   0.115 us    |                  tpm_tcg_write_bytes();
>  1) * 46426.85 us |                }
>  1) * 46427.35 us |              }
>  1)               |              tpm_tis_status() {
>  1)   1.389 us    |                tpm_tcg_read_bytes();
>  1)   1.909 us    |              }
>  1)   0.095 us    |              tpm_tis_req_canceled();
>  1)               |              tpm_tis_status() {
>  1)   0.187 us    |                tpm_tcg_read_bytes();
>  1)   2.110 us    |              }
>  1)               |              tpm_tis_recv() {
>  1)               |                wait_for_tpm_stat() {
>  1)               |                  tpm_tis_status() {
>  1)   0.082 us    |                    tpm_tcg_read_bytes();
>  1)   1.898 us    |                  }
>  1)   2.425 us    |                }
>  1)   0.102 us    |                tpm_tcg_read32();
>  1)   5.453 us    |                tpm_tcg_read_bytes();
>  1)               |                wait_for_tpm_stat() {
>  1)               |                  tpm_tis_status() {
>  1)   0.092 us    |                    tpm_tcg_read_bytes();
>  1)   1.858 us    |                  }
>  1)   2.332 us    |                }
>  1)   0.077 us    |                tpm_tcg_read_bytes();
>  1)   0.112 us    |                tpm_tcg_write_bytes();
>  1) + 25.466 us   |              }
>  1)   0.152 us    |              tpm2_commit_space();
>  1)               |              release_locality() {
>  1)   0.080 us    |                tpm_tcg_write_bytes();
>  1)   0.672 us    |              }

Releases the locality as it comes back out of tpm_transmit_cmd

>  1) * 62349.91 us |            }
>  1) * 62350.38 us |          }
>  1) * 62350.87 us |        }
>  1)   0.070 us    |        tpm_tcg_read32();
>  1)   0.073 us    |        tpm_tcg_read_bytes();
>  1)   0.096 us    |        tpm_tcg_read16();
>  1)   0.042 us    |        tpm_tcg_read32();
>  1)               |        tpm_chip_register() {
>  1)               |          tpm1_auto_startup() {
>  1)               |            tpm_get_timeouts() {
>  1)               |              tpm_get_timeouts.part.6() {
>  1)               |                tpm_getcap() {
>  1)               |                  tpm_transmit_cmd() {
>  1)               |                    tpm_transmit() {
>  1)               |                      request_locality() {
>  1)               |                        check_locality() {
>  1)   0.091 us    |                          tpm_tcg_read_bytes();
>  1)   1.680 us    |                        }
>  1)   1.973 us    |                      }

Goes to request the locality again, but once again the check sees
that the locality is already active, so doesn't go through process
of requesting the locality. Very odd.

>  1)   0.072 us    |                      tpm2_prepare_space();
>  1)               |                      tpm_tis_send() {
>  1)               |                        tpm_tis_send_main() {
>  1)               |                          tpm_tis_send_data() {
>  1)   0.043 us    |                            tpm_tcg_read_bytes();

tpm_tis_stat inlined?

>  1)   0.071 us    |                            tpm_tcg_write_bytes();

tpm_tis_ready inlined?

>  1)               |                            wait_for_tpm_stat() {
>  1)               |                              tpm_tis_status() {
>  1)   0.042 us    |                                tpm_tcg_read_bytes();
>  1)   1.634 us    |                              }
>  1)               |                              tpm_tis_status() {
>  1)   0.183 us    |                                tpm_tcg_read_bytes();
>  1)   2.121 us    |                              }
>  1) * 15942.66 us |                            }

The wait_for_tpm_stat does its loop twice checking the status register
so at this point apparently it isn't reading 0xff.

>  1)   0.108 us    |                            tpm_tcg_read32();

This read is get_burstcount.

>  1)   1.773 us    |                            tpm_tcg_write_bytes();
>  1)               |                            wait_for_tpm_stat() {
>  1)               |                              tpm_tis_status() {
>  1)   0.082 us    |                                tpm_tcg_read_bytes();
>  1)   5.011 us    |                              }
>  1)   5.618 us    |                            }
>  1)   0.077 us    |                            tpm_tcg_read_bytes();

tpm_tis_status inlined?

>  1)   0.090 us    |                            tpm_tcg_write_bytes();

Come out of loop and write last byte

>  1)               |                            wait_for_tpm_stat() {
>  1)               |                              tpm_tis_status() {
>  1)   0.080 us    |                                tpm_tcg_read_bytes();
>  1)   1.921 us    |                              }
>  1)   2.376 us    |                            }
>  1)   0.077 us    |                            tpm_tcg_read_bytes();

inlined tpm_tis_status again? Here is where it sees data is still expected and errors out.
With that debugging patch at this point it was showing that the locality was not active.
Also didn't show that the tpm had been seized by another locality.

>  1)   0.080 us    |                            tpm_tcg_write_bytes();

tpm_tis_ready inlined? in out_err

>  1) * 15970.97 us |                          }
>  1) * 15971.39 us |                        }
>  1) * 15971.81 us |                      }
>  1)               |                      release_locality() {
>  1)   0.103 us    |                        tpm_tcg_write_bytes();
>  1)   0.535 us    |                      }
>  1) * 16023.04 us |                    }
>  1) * 16023.35 us |                  }
>  1) * 16024.79 us |                }
>  1) * 16067.18 us |              }
>  1) * 16067.67 us |            }
>  1) * 16068.10 us |          }
>  1) * 16068.47 us |        }
>  1) * 78448.69 us |      }
>  1) * 78455.45 us |    }
>  1) * 78456.71 us |  }
>  1)   0.564 us    |  tpm_dev_release();
>  0)               |  tpm_pcr_read() {
>  0)   0.225 us    |    tpm_chip_find_get();
>  0)   0.734 us    |  }

I wonder if it is possible that the release locality from the probe
isn't completing on the chip until after the request/check that
happens at the beginning of the tpm_get_timeouts.  Perhaps we need
something like wait_for_tpm_stat for the access register, and
verifying that locality was released before returning out of
release_locality?

Any thoughts?
